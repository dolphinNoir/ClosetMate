//
//  RemoveBackgroundExtension.swift
//  ClosetMate
//
//  Created by johnny basgallop on 26/09/2024.
//


import Foundation
import SwiftUI
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins

extension MyWardrobeViewModel {
    // Private function to check the loading status
    func checkLoadingStatus() {
        if self.FrontImage != nil && self.BackImage != nil {
            self.isLoading = false
        }
    }

    // Function to create a sticker from the input UIImage
    func createSticker(from image: UIImage, completion: @escaping (UIImage?) -> Void) {
        guard let inputImage = CIImage(image: image)?.oriented(forExifOrientation: Int32(image.imageOrientation.exifOrientation)) else {
            print("Failed to create oriented CIImage")
            completion(nil)
            return
        }
        
        guard let maskImage = subjectMaskImage(from: inputImage) else {
            print("Failed to create mask image")
            completion(nil)
            return
        }
        
        let outputImage = apply(maskImage: maskImage, to: inputImage)
        let finalImage = render(ciImage: outputImage, originalOrientation: image.imageOrientation)
        completion(finalImage)
    }

    // Helper function to generate the subject mask
    func subjectMaskImage(from inputImage: CIImage) -> CIImage? {
        let handler = VNImageRequestHandler(ciImage: inputImage)
        let request = VNGenerateForegroundInstanceMaskRequest()
        do {
            try handler.perform([request])
        } catch {
            print("Failed to perform mask request: \(error)")
            return nil
        }
        guard let result = request.results?.first else {
            print("No observations found")
            return nil
        }
        do {
            let maskPixelBuffer = try result.generateScaledMaskForImage(forInstances: result.allInstances, from: handler)
            return CIImage(cvPixelBuffer: maskPixelBuffer)
        } catch {
            print("Failed to generate scaled mask: \(error)")
            return nil
        }
    }

    // Helper function to apply the mask to the original image
    func apply(maskImage: CIImage, to inputImage: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = inputImage
        filter.maskImage = maskImage
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage!
    }

    // Helper function to render the CIImage back to UIImage and correct its orientation
    func render(ciImage: CIImage, originalOrientation: UIImage.Orientation) -> UIImage? {
        guard let cgImage = context.createCGImage(ciImage, from: ciImage.extent) else {
            print("Failed to render CGImage")
            return nil
        }
        
        // Reapply the original orientation to the final image
        let finalImage = UIImage(cgImage: cgImage)
        
        // If the image is rotated, fix the orientation manually
        return finalImage.fixedOrientation()
    }
}
