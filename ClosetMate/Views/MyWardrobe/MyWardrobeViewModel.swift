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
    @Published var ImagesAreConverted : Bool = false
    @Published var AddItemIsPresented: Bool = false
    
    private var processingQueue = DispatchQueue(label: "ProcessingQueue")
    let standardStickerSize = CGSize(width: 500, height: 500)
    let context = CIContext()
    
    
    func closeOutSheet(){
        self.ImagesAreConverted = false
        self.FrontImage = nil
        self.BackImage = nil
        self.ItemName = nil
        self.ItemCategory = nil
        self.ItemColor = nil
        self.ItemBoughtFor = nil
        self.ItemCurrentValue = nil
        self.AddItemIsPresented = false
    }
    
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
    
    func ConvertImages() {
        guard let frontImage = self.FrontImage, let backImage = self.BackImage else { return }
        
        self.isLoading = true
        
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
        let frontImageData = self.FrontImage?.pngData()
        let backImageData = self.BackImage?.pngData()
        
        let newItem = ClothingItem(
            frontImageData: frontImageData,
            backImageData: backImageData,
            itemName: itemName,
            itemCategory: itemCategory,
            itemColor: itemColor,
            itemBoughtFor: itemBoughtFor,
            itemCurrentValue: itemCurrentValue
        )
        
        context.insert(newItem)
    }
    
    func deleteItem(item: ClothingItem, modelContext: ModelContext) {
        modelContext.delete(item)
    }
    
    
}

