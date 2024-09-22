//
//  ScanBox.swift
//  ClosetMate
//
//  Created by johnny basgallop on 22/09/2024.
//

import SwiftUI


struct ScanBox : View {
    var title: String
    var onClick: () -> Void
    
    @State private var showCamera = false
    @State var selectedImage : UIImage?
    
    var body: some View {
        VStack(alignment: .leading){
            Text("\(title)").font(.callout)
            
            Button(action: {
                self.showCamera.toggle()
            }, label: {
                ZStack{
                    Rectangle()
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.075), radius: 3, x: 0, y: 2)
                        .foregroundStyle(.white)
                    
                    if let selectedImage{
                        ZStack{
                            Button(action: {
                                self.selectedImage = nil
                                
                                
                            }, label: {
                                Image(systemName: "x.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }).zIndex(10)
                        
                            
                            Image(uiImage: selectedImage)
                                .resizable()
                                .scaledToFit()
                        }
                    }
                    
                    else{
                        VStack(spacing: 30){
                            Image(systemName: "viewfinder")
                                .font(.system(size: 45))
                                .foregroundStyle(.brandPrimary)
                            
                            Text("Click here to Scan the \(title.lowercased()) of your clothing item.")
                                .font(.system(size: 11, weight: .light))
                                .foregroundStyle(.brandAccent)
                                .padding(.horizontal, 13)
                        }
                    }
                }.frame(width: (screenWidth - 65) / 2, height: 215)
            })
        }.fullScreenCover(isPresented: self.$showCamera) {
            accessCameraView(selectedImage: $selectedImage, isFront: title == "Front" ? true : false)
        }
    }
}

struct accessCameraView: UIViewControllerRepresentable {
    @Binding var selectedImage : UIImage?
    @ObservedObject var viewModel = MyWardrobeViewModel()
    var isFront : Bool
    
    @Environment(\.presentationMode) var isPresented
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = false
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(picker: self)
    }
}

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    var picker: accessCameraView
    
    init(picker: accessCameraView) {
        self.picker = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else { return }
        if self.picker.isFront {
            self.picker.viewModel.setFrontImage(Image: selectedImage)
        }
        
        else{
            self.picker.viewModel.setBackImage(Image: selectedImage)
        }
        
        self.picker.selectedImage = selectedImage
        
        self.picker.isPresented.wrappedValue.dismiss()
    }
}

#Preview {
    ScanBox(title: "Front", onClick: {})
}
