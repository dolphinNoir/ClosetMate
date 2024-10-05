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
                        categories: ItemCategory.allCases, numberOfItems: NumberOfItems(for: selectedTopCategory)
                    )
                    
                    // Horizontal Infinite Carousel for Tops
                    InfiniteClothingCarousel(items: filteredItems(for: selectedTopCategory), selectedItem: $selectedTopItem)
                    
                    // 2. Bottom Category Selector using a dropdown menu
                    CategorySelectionView(
                        selectedCategory: $selectedBottomCategory,
                        categories: ItemCategory.allCases,
                        numberOfItems: NumberOfItems(for: selectedBottomCategory)
                    )
                    
                    // Horizontal Infinite Carousel for Bottoms
                    InfiniteClothingCarousel(items: filteredItems(for: selectedBottomCategory), selectedItem: $selectedBottomItem)
                    
                    // 3. Shoe Category Selector using a dropdown menu
                    CategorySelectionView(
                        selectedCategory: $selectedShoeCategory,
                        categories: ItemCategory.allCases, numberOfItems: NumberOfItems(for: selectedShoeCategory)
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
    
    private func NumberOfItems(for category: ItemCategory) -> Int {
        clothingItems.filter {$0.itemCategory == category}.count
    }
}

// MARK: - Reusable Category Selector Component
struct CategorySelectionView: View {
    @Binding var selectedCategory: ItemCategory
    var categories: [ItemCategory]
    var numberOfItems: Int
    
    var body: some View {
        HStack{
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
            
                Text("(\(numberOfItems))").font(.caption2).foregroundStyle(.brandAccent)
        }
        .padding(.horizontal)
    }
}

// MARK: - Infinite Clothing Carousel
struct InfiniteClothingCarousel: View {
    var items: [ClothingItem]
    @Binding var selectedItem: ClothingItem?
    @State private var currentIndex = 0
    
    // Extend the items array to create an infinite loop
    var extendedItems: [ClothingItem] {
        return items + items + items
    }
    
    // MARK: - Helper Functions for Item Type
    private func isShoeCategory(_ category: ItemCategory) -> Bool {
        return [.shoes, .sneakers, .boots, .heels].contains(category)
    }
    
    private func isTopCategory(_ category: ItemCategory) -> Bool {
        return [.shirt, .hoodie, .jacket, .sweater, .tShirt].contains(category)
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(extendedItems.indices, id: \.self) { index in
                let item = extendedItems[index % items.count] // Use modulo to cycle through original items
                
                VStack {
                    if let front = item.frontImage{
                        Image(uiImage: front)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: isShoeCategory(item.itemCategory) ? 120 : 175,
                                height: isShoeCategory(item.itemCategory) ? 120 : 175
                            )
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                selectedItem = items[index % items.count]
                            }
                            .offset(y: isTopCategory(item.itemCategory) ? 0 : -30)
                    } else {
                        Text("No image available")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 185)
        .onAppear {
            // Start in the middle of the extended array to simulate endless scrolling
            currentIndex = extendedItems.count / 3
        }
        .onChange(of: currentIndex) { newValue in
            if newValue == 0 {
                // If the user scrolls to the start of the array, jump to the middle
                currentIndex = items.count
            } else if newValue == extendedItems.count - 1 {
                // If the user scrolls to the end of the array, jump to the middle
                currentIndex = 2 * items.count - 1
            }
        }
    }
}

// MARK: - Preview
#Preview {
    PlannerView()
}
