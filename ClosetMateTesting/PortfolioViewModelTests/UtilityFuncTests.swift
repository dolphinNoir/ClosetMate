//
//  UtilityFuncTests.swift
//  ClosetMateTesting
//
//  Created by johnny basgallop on 15/10/2024.
//

import Foundation
import XCTest
import SwiftData
@testable import ClosetMate

final class UtilityFuncTests: XCTestCase{
    var viewModel : PortfolioViewModel!
    var mockClothingItems : [ClothingItem]!
    
    override func setUpWithError() throws {
        viewModel = PortfolioViewModel()
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
    
    func testTotalCurrentValue() throws {
        //Given
        let expectedValue = 170
        // When
        let totalValue = viewModel.totalCurrentValue(clothingItems: mockClothingItems)
        // Then
        XCTAssertEqual(totalValue, expectedValue, "Total current value calculation is incorrect")
    }
    
    func testItemCount() throws {
        // Given
        let expectedCount = 3
        // When
        let itemCount = viewModel.itemCount(clothingItems: mockClothingItems)
        // Then
        XCTAssertEqual(itemCount, expectedCount, "Item count calculation is incorrect")
    }
    
    
    func testTopColors() throws {
        // Given
        let expectedTopColors = [(color: ItemColor.blue, count: 3), (color: ItemColor.black, count: 1), (color: ItemColor.white, count: 1)]
        // When
        let topColors = viewModel.topColors(clothingItems: mockClothingItems, limit: 3)
        //Then
        XCTAssertEqual(topColors.count, 3, "Top colors count is incorrect")
    }
    
    func testTopCategories() throws {
        // Given
        let expectedTopCategories = [(category: ItemCategory.shirt, count: 1), (category: ItemCategory.jeans, count: 1), (category: ItemCategory.hoodie, count: 1)]
        // When
        let topCategories = viewModel.topCategories(clothingItems: mockClothingItems, limit: 3)
        //Then
        XCTAssertEqual(topCategories.count, 3, "Top categories count is incorrect")
    }
    
}
