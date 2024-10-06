//
//  PlannerViewModel.swift
//  ClosetMate
//
//  Created by johnny basgallop on 06/10/2024.
//

import Foundation

class PlannerViewModel: ObservableObject {
    @Published var selectedTopCategory: ItemCategory = .hoodie
    @Published var selectedBottomCategory: ItemCategory = .jeans
    @Published var selectedShoeCategory: ItemCategory = .shoes
    
    @Published var selectedTopItem: ClothingItem?
    @Published var selectedBottomItem: ClothingItem?
    @Published var selectedShoeItem: ClothingItem?
    
    // Helper function to filter items based on category
    func filteredItems(clothingItems: [ClothingItem], for category: ItemCategory) -> [ClothingItem] {
        clothingItems.filter { $0.itemCategory == category }
    }
    
    // Helper function to get the number of items for a given category
    func numberOfItems(clothingItems: [ClothingItem],for category: ItemCategory) -> Int {
        clothingItems.filter { $0.itemCategory == category }.count
    }
    
    // MARK: - Helper Functions for Item Type
    func isShoeCategory(clothingItems: [ClothingItem] ,category: ItemCategory) -> Bool {
        return [.shoes, .sneakers, .boots, .heels].contains(category)
    }
    
    func isTopCategory(clothingItems: [ClothingItem],category: ItemCategory) -> Bool {
        return [.shirt, .hoodie, .jacket, .sweater, .tShirt].contains(category)
    }
}
