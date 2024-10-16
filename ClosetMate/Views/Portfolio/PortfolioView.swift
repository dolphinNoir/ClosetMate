import SwiftUI
import SwiftData

struct PortfolioView: View {
    @Query var clothingItems: [ClothingItem]
    @Binding var selectedTab: Tab
    @EnvironmentObject var viewModel : PortfolioViewModel
    
    var body: some View {
        NavigationStack {
            if !clothingItems.isEmpty {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 0) {
                        PortfolioValue(
                            title: "Wardrobe Value",
                            value: "£\(viewModel.totalCurrentValue(clothingItems: clothingItems))"
                        )
                        TopColorsCard(topColors: viewModel.topColors(clothingItems: clothingItems))
                        TopCategoriesGrid(topCategories: viewModel.topCategories(clothingItems: clothingItems), clothingItems: clothingItems)
                        
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .navigationTitle(Text("Portfolio"))
                }
            } else {
                BackupView(selectedTab: $selectedTab)
            }
        }
    }
    
    
}



#Preview {
    PortfolioView(selectedTab: .constant(.third)).environmentObject(PortfolioViewModel())
}

