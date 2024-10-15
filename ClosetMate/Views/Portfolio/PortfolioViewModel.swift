//
//  PortfolioViewModel.swift
//  ClosetMate
//
//  Created by johnny basgallop on 15/10/2024.
//


import Foundation
import SwiftUI
import SwiftData

class PortfolioViewModel : ObservableObject {
    // Function to calculate total current value of the wardrobe
    func totalCurrentValue(clothingItems: [ClothingItem]) -> Int {
        return clothingItems.compactMap { $0.itemCurrentValue }.reduce(0, +)
    }
    
    // Function to get the count of clothing items
    func itemCount(clothingItems: [ClothingItem]) -> Int {
        return clothingItems.count
    }
    
    // Function to get the top 3 most used colors
    func topColors(clothingItems: [ClothingItem],limit: Int = 3) -> [(color: ItemColor, count: Int)] {
        let colorCounts = Dictionary(grouping: clothingItems, by: { $0.itemColor })
            .mapValues { $0.count }
        
        return colorCounts
            .sorted { $0.value > $1.value }
            .prefix(limit)
            .map { ($0.key, $0.value) }
    }
    
    // Function to get the top 3 categories of clothing items
    func topCategories(clothingItems: [ClothingItem],limit: Int = 3) -> [(category: ItemCategory, count: Int)] {
        let categoryCounts = Dictionary(grouping: clothingItems, by: { $0.itemCategory })
            .mapValues { $0.count }
        
        return categoryCounts
            .sorted { $0.value > $1.value }
            .prefix(limit)
            .map { ($0.key, $0.value) }
        
    }
}
