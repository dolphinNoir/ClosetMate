//
//  MyWardrobeViewModel.swift
//  ClosetMate
//
//  Created by johnny basgallop on 22/09/2024.
//

import Foundation
import SwiftUI
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftData

class MyWardrobeViewModel: ObservableObject {
    @Query var clothingItems: [ClothingItem]
    
    @Published var isLoading: Bool = false
    @Published var FrontImage: UIImage?
    @Published var BackImage: UIImage?
    @Published var ItemName: String?
    @Published var ItemCategory: ItemCategory?
    @Published var ItemColor: ItemColor?
    @Published var ItemBoughtFor: Int?
    @Published var ItemCurrentValue: Int?
    
    private var processingQueue = DispatchQueue(label: "ProcessingQueue")
    let context = CIContext()

    func setFrontImage(Image: UIImage) {
        self.FrontImage = Image
    }

    func setBackImage(Image: UIImage) {
        self.BackImage = Image
    }
    
    func clearImages() {
        self.BackImage = nil
        self.FrontImage = nil
    }
    
    func areBothImagesFilled() -> Bool {
        return self.BackImage != nil && self.FrontImage != nil
    }
    
    // Function to convert both images to stickers
    func ConvertImages() {
        guard let frontImage = self.FrontImage, let backImage = self.BackImage else { return }
        
        self.isLoading = true

        // Convert both images asynchronously to stickers, using the functionality in the RemoveBackgroundExtension
        processingQueue.async {
            self.createSticker(from: frontImage) { [weak self] sticker in
                DispatchQueue.main.async {
                    self?.FrontImage = sticker
                    self?.checkLoadingStatus()
                }
            }
            
            self.createSticker(from: backImage) { [weak self] sticker in
                DispatchQueue.main.async {
                    self?.BackImage = sticker
                    self?.checkLoadingStatus()
                }
            }
        }
    }
    
    func addClothingItem(itemName: String, itemCategory: ItemCategory, itemColor: ItemColor, itemBoughtFor: Int, itemCurrentValue: Int, context: ModelContext) {
        // Convert the images to Data using pngData() to preserve transparency
        let frontImageData = self.FrontImage?.pngData()
        let backImageData = self.BackImage?.pngData()

        // Create a new ClothingItem instance with the provided data
        let newItem = ClothingItem(
            frontImageData: frontImageData,
            backImageData: backImageData,
            itemName: itemName,
            itemCategory: itemCategory,
            itemColor: itemColor,
            itemBoughtFor: itemBoughtFor,
            itemCurrentValue: itemCurrentValue
        )

        // Insert the new item into the ModelContext for SwiftData to manage
        context.insert(newItem)
    }

    func deleteItem(item: ClothingItem, modelContext: ModelContext) {
        // Use modelContext to delete the specified item
        modelContext.delete(item)
    }

   
}

