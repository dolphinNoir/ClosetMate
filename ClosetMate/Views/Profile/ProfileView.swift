import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query var clothingItems: [ClothingItem]
    @Binding var selectedTab: Tab
    
    // MARK: - Computed Properties for Aggregation
    private var totalCurrentValue: Int {
        clothingItems.compactMap { $0.itemCurrentValue }.reduce(0, +)
    }
    
    private var itemCount: Int {
        clothingItems.count
    }
    // Get the top 3 most used colors
    private var topColors: [(color: ItemColor, count: Int)] {
        let colorCounts = Dictionary(grouping: clothingItems, by: { $0.itemColor })
            .mapValues { $0.count }
        
        return colorCounts
            .sorted { $0.value > $1.value }
            .prefix(4)
            .map { ($0.key, $0.value) }
    }
    
    // Top 3 Categories
    private var topCategories: [(category: ItemCategory, count: Int)] {
        let categoryCounts = Dictionary(grouping: clothingItems, by: { $0.itemCategory })
            .mapValues { $0.count }
        
        return categoryCounts
            .sorted { $0.value > $1.value }
            .prefix(4)
            .map { ($0.key, $0.value) }
    }
    
    var body: some View {
        NavigationStack {
            if !clothingItems.isEmpty {
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 5) {
                        PortfolioValue(
                            title: "Wardrobe Value",
                            value: "£\(totalCurrentValue)"
                        )
                        TopColorsCard(topColors: topColors)
                        TopCategoriesGrid(topCategories: topCategories, clothingItems: clothingItems)
                        
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
    ProfileView(selectedTab: .constant(.third))
}

