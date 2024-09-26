import SwiftUI
import TipKit

struct ScanBox: View {
    var title: String
    var onClick: () -> Void
    
    @State private var showImagePicker = false
    @State private var isCameraSelected = false
    @State private var showCamera = false
    @State var selectedImage: UIImage?
    @EnvironmentObject var viewModel: MyWardrobeViewModel
    let ScanTip = ScanClothingTip()
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(title)").font(.callout)
            
            Button(action: {
                self.showImagePicker.toggle()
                ScanTip.invalidate(reason: .actionPerformed)
                
            }, label: {
                ZStack {
                    Rectangle()
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.075), radius: 3, x: 0, y: 2)
                        .foregroundStyle(.white)
                    
                    if let image = selectedImage {
                        ZStack {
                            Button(action: {
                                self.selectedImage = nil
                                viewModel.clearImages()
                            }, label: {
                                Image(systemName: "x.circle.fill")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }).zIndex(10)
                            
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                        }
                    } else {
                        VStack(spacing: 30) {
                            Image(systemName: "viewfinder")
                                .font(.system(size: 55))
                                .foregroundStyle(.brandPrimary)
                            
                            Text("Click here to Scan the \(title.lowercased()) of your clothing item.")
                                .font(.system(size: 11, weight: .light))
                                .foregroundStyle(.brandAccent)
                                .padding(.horizontal, 13)
                        }.onChange(of: selectedImage) { oldValue, newValue in
                            guard let value = newValue else { return }
                            if title == "Front" {
                                viewModel.setFrontImage(Image: value)
                            } else {
                                viewModel.setBackImage(Image: value)
                            }
                        }
                    }
                }.frame(width: (screenWidth - 65), height: 185)
            })
        }
        .actionSheet(isPresented: $showImagePicker) {
            ActionSheet(title: Text("Select Image Source"), buttons: [
                .default(Text("Camera")) {
                    isCameraSelected = true
                    showCamera.toggle()
                },
                .default(Text("Photo Library")) {
                    isCameraSelected = false
                    showCamera.toggle()
                },
                .cancel()
            ])
        }
        .fullScreenCover(isPresented: $showCamera) {
            accessCameraView(selectedImage: $selectedImage, isFront: title == "Front", useCamera: isCameraSelected).environmentObject(viewModel)
        }
    }
}



#Preview {
    ScanBox(title: "Front", onClick: {})
}
