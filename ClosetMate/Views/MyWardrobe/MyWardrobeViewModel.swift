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

class MyWardrobeViewModel: ObservableObject {
    @Published var FrontImage: UIImage?
    @Published var BackImage: UIImage?
    @Published var isLoading: Bool = false
    
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

   
}

