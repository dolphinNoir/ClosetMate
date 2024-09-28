//
//  MyWardrobeView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 11/09/2024.
//

import SwiftUI
import SwiftData

struct MyWardrobeView: View {
    @StateObject var viewModel = MyWardrobeViewModel()
    @State private var SheetIsPresented : Bool = false
    @Query var clothingItems: [ClothingItem]
    var body: some View {
        VStack {
            HStack{
                Text("Your Wardrobe").font(.system(size: 36, weight: .bold))
                Spacer()
                Image(systemName: "magnifyingglass").font(.system(size: 24))
            }.padding(.top, 43)
            
            Spacer()
            
            
            if clothingItems.isEmpty{
                Text("It Appears You Dont Have Any Items To Show, Click the Add Button to begin your collection.").font(.system(size: 15)).multilineTextAlignment(.center).frame(width: screenWidth / 1.5)
            }
            
            else{
                
                ClothingList().environmentObject(viewModel)
                
            }
            
            Spacer()
            
            HStack{
                Spacer()
                AddItemButton(SheetIsPresented: $SheetIsPresented)
            }
            .sheet(isPresented: $SheetIsPresented, content: {
                SheetViewCell().environmentObject(viewModel)
            })
            
        }.padding(.horizontal, 20)
    }
}

struct ClothingList: View {
    @EnvironmentObject var viewModel: MyWardrobeViewModel
    @Query var clothingItems: [ClothingItem]

    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                LazyVStack(alignment: .leading, spacing: 20) {
                    // Step 1: Group items by their category and iterate over each category
                    ForEach(groupedItems, id: \.key) { category, items in
                        // Each Category as a Section
                        VStack(alignment: .leading) {
                            // Section Header
                            Text(category.rawValue)
                                .font(.headline)
                                .padding(.leading, 15)

                            // Step 2: Horizontal ScrollView for Items in this Category
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 15) {
                                    // Display only the images of each clothing item
                                    ForEach(items, id: \.id) { item in
                                        if let frontImage = item.frontImage {
                                            WardrobeImage(image: frontImage)
                                        }
                                    }
                                }
                                .padding(.horizontal, 15)
                            }
                        }
                    }
                }
                .padding(.vertical, 15)
            }
//            .navigationTitle("Clothing Inventory")
        }
    }

    // Grouping items by category
    private var groupedItems: [(key: ItemCategory, value: [ClothingItem])] {
        Dictionary(grouping: clothingItems, by: { $0.itemCategory })
            .sorted { $0.key.rawValue < $1.key.rawValue } // Sort the categories alphabetically
    }
}
#Preview {
    MyWardrobeView()
}

