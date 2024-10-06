import SwiftUI
import SwiftData

struct PlannerView: View {
    @Query var clothingItems: [ClothingItem]
    @EnvironmentObject var viewModel: PlannerViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // 1. Top Category Selector using a dropdown menu
                    CategorySelectionView(
                        selectedCategory: $viewModel.selectedTopCategory,
                        categories: ItemCategory.allCases,
                        numberOfItems: viewModel.numberOfItems(clothingItems: clothingItems, for: viewModel.selectedTopCategory)
                    )

                    // Horizontal Infinite Carousel for Tops
                    InfiniteClothingCarousel(
                        items: viewModel.filteredItems(clothingItems: clothingItems, for: viewModel.selectedTopCategory),
                        selectedItem: $viewModel.selectedTopItem
                    )
                    
                    // 2. Bottom Category Selector using a dropdown menu
                    CategorySelectionView(
                        selectedCategory: $viewModel.selectedBottomCategory,
                        categories: ItemCategory.allCases,
                        numberOfItems: viewModel.numberOfItems(clothingItems: clothingItems, for: viewModel.selectedBottomCategory)
                    )

                    // Horizontal Infinite Carousel for Bottoms
                    InfiniteClothingCarousel(
                        items: viewModel.filteredItems(clothingItems: clothingItems, for: viewModel.selectedBottomCategory),
                        selectedItem: $viewModel.selectedBottomItem
                    )
                    
                    // 3. Shoe Category Selector using a dropdown menu
                    CategorySelectionView(
                        selectedCategory: $viewModel.selectedShoeCategory,
                        categories: ItemCategory.allCases,
                        numberOfItems: viewModel.numberOfItems(clothingItems: clothingItems, for: viewModel.selectedShoeCategory)
                    )

                    // Horizontal Infinite Carousel for Shoes
                    InfiniteClothingCarousel(
                        items: viewModel.filteredItems(clothingItems: clothingItems, for: viewModel.selectedShoeCategory),
                        selectedItem: $viewModel.selectedShoeItem
                    )
                    
                    Spacer()
                }
                .padding()
                .navigationTitle(Text("Outfit Planner"))
            }
        }
    }
}


#Preview {
    PlannerView().environmentObject(PlannerViewModel())
}
