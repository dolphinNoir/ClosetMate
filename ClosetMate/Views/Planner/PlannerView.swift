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


#Preview {
    PlannerView()
}
