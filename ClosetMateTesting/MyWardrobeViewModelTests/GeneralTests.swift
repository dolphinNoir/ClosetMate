//
//  GeneralTests.swift
//  ClosetMateTesting
//
//  Created by johnny basgallop on 14/10/2024.
//

import Foundation
import XCTest
import SwiftData
@testable import ClosetMate

final class GeneralTests: XCTestCase {
    
    var viewModel : MyWardrobeViewModel!
    var context : ModelContext!
    override func setUpWithError() throws {
        // Create in-memory ModelContainer
        let container = try! ModelContainer(for: ClothingItem.self)
        context = ModelContext(container)
        viewModel = MyWardrobeViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        context = nil
    }
    
    func testCloseOutSheet(){
        //given
        viewModel.ImagesAreConverted = true
        viewModel.FrontImage = UIImage(systemName: "photo")
        viewModel.BackImage = UIImage(systemName: "photo")
        viewModel.ItemName = "TestingName"
        viewModel.ItemCategory = ItemCategory.blazer
        viewModel.ItemBoughtFor = 40
        viewModel.ItemCurrentValue = 30
        viewModel.AddItemIsPresented = true
        //when
        viewModel.closeOutSheet()
        //then
        XCTAssertFalse(viewModel.ImagesAreConverted, "images are converted should be set to false")
        XCTAssertNil(viewModel.FrontImage, "the front image should be set to nil")
        XCTAssertNil(viewModel.BackImage, "the back image should be set to nil")
        XCTAssertNil(viewModel.ItemName, "the item name should be set to nil")
        XCTAssertNil(viewModel.ItemBoughtFor, "the item bought for value should be set to nil")
        XCTAssertNil(viewModel.ItemCurrentValue, "the item current value should be set to nil")
        XCTAssertFalse(viewModel.AddItemIsPresented, "Add item is presented should be set to false to close the sheet")
    }
}

