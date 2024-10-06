//
//  AccessCameraView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 26/09/2024.
//

import Foundation
import SwiftUI
import UIKit

struct accessCameraView: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @EnvironmentObject var viewModel: MyWardrobeViewModel
    var isFront: Bool
    var useCamera: Bool
    
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = useCamera ? .camera : .photoLibrary
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        
        if self.picker.isFront {
            self.picker.viewModel.setFrontImage(Image: selectedImage)
        } else {
            self.picker.viewModel.setBackImage(Image: selectedImage)
        }
        
        self.picker.selectedImage = selectedImage
        self.picker.isPresented.wrappedValue.dismiss()
    }
}
