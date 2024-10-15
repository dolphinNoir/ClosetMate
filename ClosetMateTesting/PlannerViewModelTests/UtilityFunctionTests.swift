//
//  UtilityFunctionTests.swift
//  ClosetMateTesting
//
//  Created by johnny basgallop on 15/10/2024.
//

import Foundation
import XCTest
import SwiftData
@testable import ClosetMate

final class UtilityFunctionTests: XCTestCase{
    var viewModel : PlannerViewModel!
    var mockClothingItems : [ClothingItem]!
    
    override func setUpWithError() throws {
        viewModel = PlannerViewModel()
        mockClothingItems = [
            ClothingItem(
                frontImageData: UIImage(systemName: "photo")?.pngData(),
                backImageData: UIImage(systemName: "photo")?.pngData(),
                itemName: "Hoodie",
                itemCategory: .hoodie,
                itemColor: .blue,
                itemBoughtFor: 50,
                itemCurrentValue: 40
            ),
            ClothingItem(
                frontImageData: UIImage(systemName: "photo")?.pngData(),
                backImageData: UIImage(systemName: "photo")?.pngData(),
                itemName: "Jeans",
                itemCategory: .jeans,
                itemColor: .black,
                itemBoughtFor: 60,
                itemCurrentValue: 50
            ),
            ClothingItem(
                frontImageData: UIImage(systemName: "photo")?.pngData(),
                backImageData: UIImage(systemName: "photo")?.pngData(),
                itemName: "Sneakers",
                itemCategory: .shoes,
                itemColor: .white,
                itemBoughtFor: 100,
                itemCurrentValue: 80
            )
        ]
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        mockClothingItems = nil
    }
    
    func testFilteredItems() {
        // when
        let filteredTops = viewModel.filteredItems(clothingItems: mockClothingItems, for: .hoodie)
        // Then
        XCTAssertEqual(filteredTops.count, 1, "Should only return 1 item for hoodie category")
        XCTAssertEqual(filteredTops.first?.itemName, "Hoodie", "The filtered top should be 'Hoodie'")
    }
    
    func testNumberOfItems() {
        // when
        let topItemCount = viewModel.numberOfItems(clothingItems: mockClothingItems, for: .hoodie)
        let bottomItemCount = viewModel.numberOfItems(clothingItems: mockClothingItems, for: .jeans)
        let shoeItemCount = viewModel.numberOfItems(clothingItems: mockClothingItems, for: .shoes)
        
        // Then
        XCTAssertEqual(topItemCount, 1, "Should have 1 item in hoodie category")
        XCTAssertEqual(bottomItemCount, 1, "Should have 1 item in jeans category")
        XCTAssertEqual(shoeItemCount, 1, "Should have 1 item in shoes category")
    }
    
    func testIsShoeCategory() {
        // When
        let isShoe = viewModel.isShoeCategory(clothingItems: mockClothingItems, category: .shoes)
        let isNotShoe = viewModel.isShoeCategory(clothingItems: mockClothingItems, category: .hoodie)
        // Then
        XCTAssertTrue(isShoe, "Shoes category should return true")
        XCTAssertFalse(isNotShoe, "Hoodie category should return false for shoes check")
    }
    
    func testIsTopCategory() {
        // When
        let isTop = viewModel.isTopCategory(clothingItems: mockClothingItems, category: .hoodie)
        let isNotTop = viewModel.isTopCategory(clothingItems: mockClothingItems, category: .shoes)
        
        // Then
        XCTAssertTrue(isTop, "Hoodie category should return true for top category")
        XCTAssertFalse(isNotTop, "Shoes category should return false for top category check")
    }
    
    
}
