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
            currentIndex = extendedItems.count / 3
        }
        .onChange(of: currentIndex) { newValue in
            if newValue == 0 {
                currentIndex = items.count
            } else if newValue == extendedItems.count - 1 {
                currentIndex = 2 * items.count - 1
            }
        }
    }
}

