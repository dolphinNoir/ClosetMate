import SwiftUI

struct ImageCarousel: View {
    @EnvironmentObject var viewModel: MyWardrobeViewModel
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    var FrontImage: UIImage?
    var BackImage: UIImage?
    
    var body: some View {
        VStack(spacing: 20) {
            TabView(selection: $currentIndex) {
                // Front Image
                if let front = FrontImage {
                    Image(uiImage: front)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 260, height: 260)
                        .padding()
                        .tag(0)
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: screenWidth - 45, maxHeight: 350)
                        .padding()
                        .tag(0)
                }
                
                // Back Image
                if let back = BackImage {
                    Image(uiImage: back)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 260, height: 260)
                        .padding()
                        .tag(1)
                } else {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: screenWidth - 45, maxHeight: 350)
                        .padding()
                        .tag(1)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(width: screenWidth - 45, height: 350)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 7, x: 0, y: 4)
        }
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % 2
            }
        }
    }
}
