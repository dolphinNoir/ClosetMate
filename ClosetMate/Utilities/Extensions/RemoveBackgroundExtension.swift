// RemoveBackgroundExtension.swift
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
            self.ImagesAreConverted = true
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
        
        // Crop the mask to the subject's bounding box
        let croppedMask = cropMaskToBoundingBox(maskImage: maskImage)
        
        // Resize and normalize both the mask and the original image to fit the uniform size
        let normalizedMask = normalizeToUniformSize(maskImage: croppedMask, targetSize: standardStickerSize)
        let normalizedInputImage = normalizeToUniformSize(maskImage: inputImage, targetSize: standardStickerSize)
        
        // Combine the scaled images into a single sticker
        let outputImage = apply(maskImage: normalizedMask, to: normalizedInputImage)
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
    
    // Helper function to crop the mask image to the bounding box of the subject
    private func cropMaskToBoundingBox(maskImage: CIImage) -> CIImage {
        let extent = maskImage.extent
        let maskCropRect = maskImage.extent // Use the full extent if bounding box isn't provided
        return maskImage.cropped(to: maskCropRect)
    }
    
    // Helper function to resize and center the image within the target size while maintaining its aspect ratio
    private func normalizeToUniformSize(maskImage: CIImage, targetSize: CGSize) -> CIImage {
        // Get the aspect ratios for width and height
        let maskAspectRatio = maskImage.extent.width / maskImage.extent.height
        let targetAspectRatio = targetSize.width / targetSize.height

        // Calculate the scaling factors to fit the mask within the target size
        let scaleFactor: CGFloat
        if maskAspectRatio > targetAspectRatio {
            // The mask is wider than the target size
            scaleFactor = targetSize.width / maskImage.extent.width
        } else {
            // The mask is taller or has the same aspect ratio as the target size
            scaleFactor = targetSize.height / maskImage.extent.height
        }

        // Resize the mask proportionally
        let resizeFilter = CIFilter.lanczosScaleTransform()
        resizeFilter.inputImage = maskImage
        resizeFilter.scale = Float(scaleFactor) // Scale factor is a Float type for CIFilter
        resizeFilter.aspectRatio = 1.0 // Maintain original aspect ratio

        guard let scaledImage = resizeFilter.outputImage else { return maskImage }

        // Calculate the offset to center the image within the target size
        let xOffset = (targetSize.width - scaledImage.extent.width) / 2
        let yOffset = (targetSize.height - scaledImage.extent.height) / 2
        let transform = CGAffineTransform(translationX: xOffset, y: yOffset)

        return scaledImage.transformed(by: transform)
    }
    
    // Helper function to apply the mask to the original image
    private func apply(maskImage: CIImage, to inputImage: CIImage) -> CIImage {
        let filter = CIFilter.blendWithMask()
        filter.inputImage = inputImage
        filter.maskImage = maskImage
        filter.backgroundImage = CIImage.empty()
        return filter.outputImage!
    }
    
    // Helper function to render the CIImage back to UIImage and correct its orientation
    private func render(ciImage: CIImage, originalOrientation: UIImage.Orientation) -> UIImage? {
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
