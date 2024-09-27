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
                    List(clothingItems, id:  \.self){ item in
                        Text(item.itemName)
                    }
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

#Preview {
    MyWardrobeView()
}
 
