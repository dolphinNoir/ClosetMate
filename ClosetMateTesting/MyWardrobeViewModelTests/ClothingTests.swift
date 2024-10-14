//
//  ClothingTests.swift
//  ClosetMateTesting
//
//  Created by johnny basgallop on 14/10/2024.
//

import Foundation
import XCTest
@testable import ClosetMate
import SwiftData

final class ClothingTests: XCTestCase{
    var viewModel : MyWardrobeViewModel!
    var context : ModelContext!
    
    override func setUpWithError() throws {
        let container = try! ModelContainer(for: ClothingItem.self)
        context = ModelContext(container)
        viewModel = MyWardrobeViewModel()
    }
    
    override func tearDownWithError() throws {
        context = nil
        viewModel = nil
    }
    
    
    func testAddClothingItem() throws{
        //given
        let currentItemCount = try context.fetch(FetchDescriptor<ClothingItem>()).count
        let itemName = "Test Hoodie"
        let itemCategory = ItemCategory.hoodie
        let itemColor = ItemColor.blue
        let itemBoughtFor = 100
        let itemCurrentValue = 80
        //when
        viewModel.addClothingItem(itemName: itemName, itemCategory: itemCategory, itemColor: itemColor, itemBoughtFor: itemBoughtFor, itemCurrentValue: itemCurrentValue, context: context)
        //then
        let items = try context.fetch(FetchDescriptor<ClothingItem>())
        XCTAssertTrue(items.count == currentItemCount + 1, "the item count should go up by one")
        XCTAssertEqual(items.first?.itemName, "Test Hoodie", "item names should match")
        XCTAssertEqual(items.first?.itemCategory, .hoodie, "item categories should match")
        XCTAssertEqual(items.first?.itemColor, .blue, "item colors should match")
        XCTAssertEqual(items.first?.itemBoughtFor, 100, "item prices should match")
        XCTAssertEqual(items.first?.itemCurrentValue, 80, "item prices should match")
    }
    
    func testDeleteClothingItem() throws{
        func testDeleteClothingItem() throws {
            // Given: Add a clothing item to the context
            viewModel.addClothingItem(itemName: "Hoodie",
                                      itemCategory: .hoodie,
                                      itemColor: .blue,
                                      itemBoughtFor: 50,
                                      itemCurrentValue: 30,
                                      context: context)
            
            // Fetch the items after adding, to make sure the item is added
            var items = try context.fetch(FetchDescriptor<ClothingItem>())
            XCTAssertEqual(items.count, 1)
            
            // When: Delete the item from the context
            if let itemToDelete = items.first {
                viewModel.deleteItem(item: itemToDelete, modelContext: context)
            }
            
            // Fetch the items again after deletion
            items = try context.fetch(FetchDescriptor<ClothingItem>())
            
            // Then: Assert that there are no items left in the context
            XCTAssertEqual(items.count, 0, "The item should be deleted from the context.")
        }
    }
    
}
