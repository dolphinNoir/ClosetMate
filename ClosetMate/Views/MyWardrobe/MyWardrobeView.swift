import SwiftUI
import SwiftData

struct MyWardrobeView: View {
    @EnvironmentObject var viewModel : MyWardrobeViewModel
    @State private var SheetIsPresented: Bool = false
    @Query var clothingItems: [ClothingItem]
    @State private var ItemToEdit: ClothingItem?
    @State private var searchText = ""  // Search text state variable
    @State private var navigationPath = NavigationPath()
    var body: some View {
        
        NavigationStack{
            VStack{
                Spacer()
                
                if clothingItems.isEmpty {
                    Text("It Appears You Dont Have Any Items To Show, Click the Add Button to begin your collection.")
                        .font(.system(size: 15))
                        .multilineTextAlignment(.center)
                        .frame(width: screenWidth / 1.5)
                } else {
                    // Pass the filtered items to the ClothingList component
                    ClothingList(clothingItems: filteredClothingItems)
                        .environmentObject(viewModel)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    AddItemButton(SheetIsPresented: $viewModel.AddItemIsPresented, navigationPath: $navigationPath)
                }
                .sheet(isPresented: $viewModel.AddItemIsPresented,onDismiss:{
                    navigationPath = NavigationPath()
                }, content: {
                    SheetViewCell( navigationPath: $navigationPath)
                        .environmentObject(viewModel)
                })
            }
            .padding(.horizontal, 20)
            .navigationTitle(Text("Wardrobe"))
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
        }
    }
    
    // Filtered clothing items based on the search text
    private var filteredClothingItems: [ClothingItem] {
        if searchText.isEmpty {
            return clothingItems
        } else {
            return clothingItems.filter { $0.itemName.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ClothingList: View {
    @EnvironmentObject var viewModel: MyWardrobeViewModel
    var clothingItems: [ClothingItem]  // Use filtered clothing items passed from parent
    @State private var ItemToEdit: ClothingItem?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                // Group items by their category and iterate over each category
                ForEach(groupedItems, id: \.key) { category, items in
                    VStack(alignment: .leading) {
                        // Section Header
                        Text(category.rawValue)
                            .font(.headline)
                            .padding(.leading, 15)
                        
                        // Horizontal ScrollView for Items in this Category
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
                                // Display only the images of each clothing item
                                ForEach(items, id: \.id) { item in
                                    if let frontImage = item.frontImage {
                                        WardrobeImage(image: frontImage, name: item.itemName)
                                            .onTapGesture {
                                                ItemToEdit = item
                                            }
                                    }
                                }
                            }
                            .padding(.horizontal, 15)
                        }
                    }
                }
            }
            .padding(.top, 15)
        }
        .sheet(item: $ItemToEdit) { item in
            UpdateItem(Item: item).environmentObject(viewModel)
        }
    }
    
    // Group items by category
    private var groupedItems: [(key: ItemCategory, value: [ClothingItem])] {
        Dictionary(grouping: clothingItems, by: { $0.itemCategory })
            .sorted { $0.key.rawValue < $1.key.rawValue } // Sort categories alphabetically
    }
}

// Preview for testing
#Preview {
    MyWardrobeView()
}
