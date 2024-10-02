import SwiftUI
import SwiftData

struct ProfileView: View {
    @Query var clothingItems: [ClothingItem]
    @Binding var selectedTab : Tab
    var body: some View {
        NavigationStack {
            if !clothingItems.isEmpty {
                VStack(spacing: 5) {
                    // 1. Wardrobe Value Card
                    PortfolioCurrentValue(
                        title: "Wardrobe Value",
                        value: "£\(totalCurrentValue)"
                    )
                    
                    // 2. Most Expensive Item Card
                    if let expensiveItem = mostExpensiveItem {
                        MostExpensiveItemCard(item: expensiveItem)
                    }
                    
                    // 3. Top 3 Colors Card
                    TopColorsCard(topColors: topThreeColors)
                    
                    Spacer()
                }
                .padding(.horizontal, 20)
                .navigationTitle(Text("Portfolio"))
            }
            else{
                VStack(spacing: 50){
                    Text("in order to view portfolio stats you must first add at least 3 items").multilineTextAlignment(.center).padding(.horizontal, 50)
                    
                    ZStack{
                        Rectangle()
                            .fill(.brandLightGray)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                        Button(action: {
                            selectedTab = .second
                        }, label: {
                            Text("Add item").foregroundStyle(.brandPrimary)
                        })
                    }.frame(width: 150, height: 50)
                }.navigationTitle(Text("Portfolio"))
                

            }
                
        }
    }
    
    // MARK: - Computed Properties for Aggregation
    private var totalCurrentValue: Int {
        clothingItems.compactMap { $0.itemCurrentValue }.reduce(0, +)
    }

    private var itemCount: Int {
        clothingItems.count
    }
    
    // 1. Find the most expensive item in the wardrobe
    private var mostExpensiveItem: ClothingItem? {
        clothingItems.max(by: { ($0.itemCurrentValue ?? 0) < ($1.itemCurrentValue ?? 0) })
    }
    
    // 2. Get the top 3 most used colors
    private var topThreeColors: [(color: ItemColor, count: Int)] {
        // Count occurrences of each color
        let colorCounts = Dictionary(grouping: clothingItems, by: { $0.itemColor })
            .mapValues { $0.count }
        
        // Sort and get the top 3 colors
        return colorCounts
            .sorted { $0.value > $1.value }
            .prefix(3)
            .map { ($0.key, $0.value) }
    }
}

// MARK: - Custom View Component for Value Display
struct PortfolioCurrentValue: View {
    var title: String
    var value: String
    var valueColor: Color = .primary
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text(title)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack{
                Text(value)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(valueColor)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .frame(width: (screenWidth - 45), height: 130)
        .background(Color(.systemGray6))
        .cornerRadius(15)
//        .shadow(color: Color.black.opacity(0.07), radius: 5, x: 0, y: 3)
        .padding(.vertical, 10)
    }
}

// MARK: - Custom View for Most Expensive Item
struct MostExpensiveItemCard: View {
    var item: ClothingItem
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Most Expensive Item")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack {
                Text(item.itemName)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Text("£\(item.itemCurrentValue ?? 0)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.brandPrimary)
            }
            .padding(.horizontal, 20)
        }
        .frame(width: (screenWidth - 45), height: 120)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.vertical, 10)
    }
}

// MARK: - Custom View for Top Colors
struct TopColorsCard: View {
    var topColors: [(color: ItemColor, count: Int)]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Top 3 Colors")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack(spacing: 20) {
                ForEach(topColors, id: \.color) { color, count in
                    VStack {
                        // Rectangle showing the color
                        Rectangle()
                            .fill(Color(hex: color.rawValue))
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            )
                        Text(color.rawValue)
                            .font(.caption2)
                            .foregroundColor(.brandAccent)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(width: (screenWidth - 45), height: 150)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.vertical, 10)
    }
}


#Preview {
    ProfileView( selectedTab: .constant(.third))
}

