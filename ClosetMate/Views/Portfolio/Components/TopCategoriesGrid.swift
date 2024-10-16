import SwiftUI

struct TopCategoriesGrid: View {
    var topCategories: [(category: ItemCategory, count: Int)]
    var clothingItems: [ClothingItem]  // The full list of clothing items
    
    private func NumberOfItems(for category: ItemCategory) -> Int {
        clothingItems.filter {$0.itemCategory == category}.count
    }// New property for the image
    // Define a two-column grid layout
    let columns = [
        GridItem(.flexible(), spacing: 5),
        GridItem(.flexible(), spacing: 5)
    ]
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Text("Top Categories")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }.padding(.horizontal)
            
            LazyVGrid(columns: columns, spacing: 5) {
                ForEach(topCategories, id: \.category) { category, count in
                    // Find one item from the current category
                    if let item = clothingItems.first(where: { $0.itemCategory == category }) {
                        CategoryCard(category: category, count: count, frontImage: item.frontImage, numberOfItems: NumberOfItems(for: category))
                    }
                }
            }
        }
        .cornerRadius(15)
        .padding(.vertical, 10)
    }
}

// MARK: - Individual Category Card
struct CategoryCard: View {
    var category: ItemCategory
    var count: Int
    var frontImage: UIImage?
    var numberOfItems: Int
    
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.brandLightGray)
                .frame(width: (screenWidth - 50) / 2, height: 160)
            
            VStack(spacing: 0) {
                if let image = frontImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .padding(15)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 75, height: 75)
                        .foregroundColor(.gray)
                }
                
                Text(category.rawValue.last == "s" ? "\(category.rawValue) (\(numberOfItems))" : "\(category.rawValue)s (\(numberOfItems))")
                    .foregroundStyle(.brandAccent)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)
            }
            .padding()
        }
    }
}




