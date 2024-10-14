//
//  MyWardrobViewModelTests.swift
//  ClosetMateTests
//
//  Created by johnny basgallop on 14/10/2024.
//

import Foundation
import XCTest
@testable import ClosetMate

final class ImageTesting: XCTestCase {
    var viewModel : MyWardrobeViewModel!
    
    override func setUpWithError() throws {
        viewModel = MyWardrobeViewModel()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
    }
    
//    Setting Image Assertions
    func testSetFrontImage(){
        //given
        let image = UIImage(systemName: "photo")
        //when
        viewModel.setFrontImage(Image: image!)
        //then
        XCTAssertEqual(viewModel.FrontImage, image, "The Front Image should be set to image we passed in")
    }
    
    func testSetBackImage(){
        //given
        let image = UIImage(systemName: "photo")
        //when
        viewModel.setBackImage(Image: image!)
        //then
        XCTAssertEqual(viewModel.BackImage, image, "The Back Image should be set to image we passed in")
    }
    
    func testAreBothImagesFilled_True(){
        //given
        let front = UIImage(systemName: "photo")
        let back = UIImage(systemName: "photo")
        viewModel.FrontImage = front
        viewModel.BackImage = back
        //when
        let result = viewModel.areBothImagesFilled()
        //then
        XCTAssertTrue(result, "When both a valid front and back UiImage are passed in, the function should return true")
        
    }
    
    func testAreBothImagesFilled_False(){
        //given
        let front = UIImage(systemName: "photo")
        viewModel.FrontImage = front
        //when
        let result = viewModel.areBothImagesFilled()
        //then
        XCTAssertFalse(result, "When there is not a valid front and back, or there is only on of either, the function should return false")
    }
    
    func testConvertImages_IsImages() {
        //given
        let image = UIImage(systemName: "photo")
        viewModel.FrontImage = image
        viewModel.BackImage = image
        viewModel.isLoading = false
        //when
        viewModel.ConvertImages()
        //then
        XCTAssertTrue(viewModel.isLoading, "a valid front and back image, should cause the loading state to be set to true")
        XCTAssertNotNil(viewModel.FrontImage, "the sticker created from the conversion should not be nil")
        XCTAssertNotNil(viewModel.BackImage, "the sticker created from the conversion should not be nil")
    }
    
    func testConvertImages_NoImages() {
        //given
        let image = UIImage(systemName: "photo")
        viewModel.isLoading = false
        //when
        viewModel.ConvertImages()
        //then
        XCTAssertFalse(viewModel.isLoading, "when there are no images, the loading state shouldnt be changed to true")
    }
    
    func testClearImages() {
        //given
        let front = UIImage(systemName: "photo")
        let back = UIImage(systemName: "photo")
        viewModel.FrontImage = front
        viewModel.BackImage = back
        //when
        viewModel.clearImages()
        //then
        XCTAssertNil(viewModel.FrontImage, "the front image should be nil if its cleared properly")
        XCTAssertNil(viewModel.BackImage, "the back image should be nil if its cleared properly")
    }
}


