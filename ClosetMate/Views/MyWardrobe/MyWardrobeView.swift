import SwiftUI
import SwiftData

struct MyWardrobeView: View {
    @StateObject var viewModel = MyWardrobeViewModel()
    @State private var SheetIsPresented: Bool = false
    @Query var clothingItems: [ClothingItem]
    @State private var ItemToEdit: ClothingItem?
    @State private var searchText = ""
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
    var clothingItems: [ClothingItem]
    @State private var ItemToEdit: ClothingItem?
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVStack(alignment: .leading, spacing: 20) {
                ForEach(groupedItems, id: \.key) { category, items in
                    VStack(alignment: .leading) {
                        Text(category.rawValue)
                            .font(.headline)
                            .padding(.leading, 15)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 15) {
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
    
    private var groupedItems: [(key: ItemCategory, value: [ClothingItem])] {
        Dictionary(grouping: clothingItems, by: { $0.itemCategory })
            .sorted { $0.key.rawValue < $1.key.rawValue }
    }
}

#Preview {
    MyWardrobeView()
}
