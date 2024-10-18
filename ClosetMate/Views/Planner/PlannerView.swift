import SwiftUI
import SwiftData

struct PlannerView: View {
    @Query var clothingItems: [ClothingItem]
    @EnvironmentObject var viewModel: PlannerViewModel
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    CategorySelectionView(
                        selectedCategory: $viewModel.selectedTopCategory,
//                        categories: ItemCategory.allCases,
                        numberOfItems: viewModel.numberOfItems(clothingItems: clothingItems, for: viewModel.selectedTopCategory)
                    )
                    
                    InfiniteClothingCarousel(
                        items: viewModel.filteredItems(clothingItems: clothingItems, for: viewModel.selectedTopCategory),
                        selectedItem: $viewModel.selectedTopItem
                    )
                    
                    CategorySelectionView(
                        selectedCategory: $viewModel.selectedBottomCategory,
//                        categories: ItemCategory.allCases,
                        numberOfItems: viewModel.numberOfItems(clothingItems: clothingItems, for: viewModel.selectedBottomCategory)
                    )
                    
                    InfiniteClothingCarousel(
                        items: viewModel.filteredItems(clothingItems: clothingItems, for: viewModel.selectedBottomCategory),
                        selectedItem: $viewModel.selectedBottomItem
                    )
                    
                    CategorySelectionView(
                        selectedCategory: $viewModel.selectedShoeCategory,
//                        categories: ItemCategory.allCases,
                        numberOfItems: viewModel.numberOfItems(clothingItems: clothingItems, for: viewModel.selectedShoeCategory)
                    )
                    
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
