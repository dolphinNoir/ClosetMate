import SwiftUI
import SwiftData

struct PlannerView: View {
    @Query var clothingItems: [ClothingItem]
    
    // Define the selected category for tops, bottoms, and shoes
    @State private var selectedTopCategory: ItemCategory = .hoodie
    @State private var selectedBottomCategory: ItemCategory = .jeans
    @State private var selectedShoeCategory: ItemCategory = .shoes

    // Define the selected item for each category
    @State private var selectedTopItem: ClothingItem?
    @State private var selectedBottomItem: ClothingItem?
    @State private var selectedShoeItem: ClothingItem?

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // 1. Top Category Selector using a dropdown menu
                    CategorySelectionView(
                        selectedCategory: $selectedTopCategory,
                        categories: ItemCategory.allCases
                    )

                    // Horizontal Infinite Carousel for Tops
                    InfiniteClothingCarousel(items: filteredItems(for: selectedTopCategory), selectedItem: $selectedTopItem)
                    
                    // 2. Bottom Category Selector using a dropdown menu
                    CategorySelectionView(
                        selectedCategory: $selectedBottomCategory,
                        categories: ItemCategory.allCases
                    )

                    // Horizontal Infinite Carousel for Bottoms
                    InfiniteClothingCarousel(items: filteredItems(for: selectedBottomCategory), selectedItem: $selectedBottomItem)
                    
                    // 3. Shoe Category Selector using a dropdown menu
                    CategorySelectionView(
                        selectedCategory: $selectedShoeCategory,
                        categories: ItemCategory.allCases
                    )

                    // Horizontal Infinite Carousel for Shoes
                    InfiniteClothingCarousel(items: filteredItems(for: selectedShoeCategory), selectedItem: $selectedShoeItem)
                    
                    Spacer()
                }
                .padding()
                .navigationTitle(Text("Outfit Planner"))
            }
        }
    }
    
    // MARK: - Helper Functions to Filter Items
    private func filteredItems(for category: ItemCategory) -> [ClothingItem] {
        clothingItems.filter { $0.itemCategory == category }
    }
    
//    // MARK: - Clothing Type Filters
//    private func isTopCategory(_ category: ItemCategory) -> Bool {
//        return [.shirt, .hoodie, .jacket, .sweater, .tShirt].contains(category)
//    }
//    
//    private func isBottomCategory(_ category: ItemCategory) -> Bool {
//        return [.jeans, .trousers, .shorts, .skirt, .joggers].contains(category)
//    }
//    
//    private func isShoeCategory(_ category: ItemCategory) -> Bool {
//        return [.shoes, .sneakers, .boots, .heels].contains(category)
//    }
}

// MARK: - Reusable Category Selector Component
struct CategorySelectionView: View {
    @Binding var selectedCategory: ItemCategory
    var categories: [ItemCategory]

    var body: some View {
        HStack {
            Menu {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category.rawValue)
                    }
                }
            } label: {
                Text(selectedCategory.rawValue)
                    .font(.footnote)
                    .foregroundColor(.brandPrimary)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(.brandPrimary, lineWidth: 1))
            }
            Spacer()
        }
        .padding(.horizontal)
    }
}

// MARK: - Infinite Clothing Carousel
struct InfiniteClothingCarousel: View {
    private func isShoeCategory(_ category: ItemCategory) -> Bool {
        return [.shoes, .sneakers, .boots, .heels].contains(category)
    }
    
    private func isTopCategory(_ category: ItemCategory) -> Bool {
        return [.shirt, .hoodie, .jacket, .sweater, .tShirt].contains(category)
    }
    
    var items: [ClothingItem]
    @Binding var selectedItem: ClothingItem?
    @State private var currentIndex = 0
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(items.indices, id: \.self) { index in
                let item = items[index]
                
                VStack {
                    if let imageData = item.frontImageData, let image = UIImage(data: imageData) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: isShoeCategory(item.itemCategory) ? 125 : 180, height: isShoeCategory(item.itemCategory) ? 125 : 180)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .offset(y: isTopCategory(item.itemCategory) ? 0 : -40)
                    } else {
                        if item.itemCategory.rawValue.last == "s"{
                            Text("You dont have any \(item.itemCategory.rawValue)")
                        }
                        else{
                            Text("You dont have any \(item.itemCategory.rawValue)s")
                        }
                    }
                }
                .tag(index)
            }
            Spacer()
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 185)
        .onChange(of: currentIndex) { newValue in
            if newValue == 0 {
                currentIndex = items.count - 1
            } else if newValue == items.count - 1 {
                currentIndex = 0
            }
        }
    }
}

#Preview {
    PlannerView()
}
