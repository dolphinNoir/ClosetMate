//
//  InfinitClothingCarousel.swift
//  ClosetMate
//
//  Created by johnny basgallop on 06/10/2024.
//

import SwiftUI

struct InfiniteClothingCarousel: View {
    var items: [ClothingItem]
    @Binding var selectedItem: ClothingItem?
    @State private var currentIndex = 0
    @EnvironmentObject var viewModel : PlannerViewModel
    // Extend the items array to create an infinite loop
    var extendedItems: [ClothingItem] {
        return items + items + items
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(extendedItems.indices, id: \.self) { index in
                let item = extendedItems[index % items.count] // Use modulo to cycle through original items
                
                VStack {
                    if let front = item.frontImage{
                        Image(uiImage: front)
                            .resizable()
                            .scaledToFill()
                            .frame(
                                width: viewModel.isShoeCategory(clothingItems: items ,category: item.itemCategory) ? 120 : 175,
                                height: viewModel.isShoeCategory(clothingItems: items ,category: item.itemCategory) ? 120 : 175
                            )
                            .padding()
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .onTapGesture {
                                selectedItem = items[index % items.count]
                            }
//                            .offset(y: viewModel.isTopCategory(clothingItems: items ,category: item.itemCategory) ? 0 : -30)
                    } else {
                        Text("No image available")
                            .foregroundColor(.gray)
                            .font(.caption)
                    }
                }
                .tag(index)
            }
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .frame(height: 185)
        .onAppear {
            // Start in the middle of the extended array to simulate endless scrolling
            currentIndex = extendedItems.count / 3
        }
        .onChange(of: currentIndex) { newValue in
            if newValue == 0 {
                // If the user scrolls to the start of the array, jump to the middle
                currentIndex = items.count
            } else if newValue == extendedItems.count - 1 {
                // If the user scrolls to the end of the array, jump to the middle
                currentIndex = 2 * items.count - 1
            }
        }
    }
}

//#Preview {
//    InfiniteClothingCarousel()
//}
