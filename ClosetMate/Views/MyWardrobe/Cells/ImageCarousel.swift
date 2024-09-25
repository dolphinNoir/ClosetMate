import SwiftUI

struct ImageCarousel: View {
    @EnvironmentObject var viewModel: MyWardrobeViewModel
    @State private var currentIndex = 0
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing: 20) {
            TabView(selection: $currentIndex) {
                // Front Image
                if let frontImage = viewModel.FrontImage {
                    Image(uiImage: frontImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300) // Adjust the size to make it a square
                        .padding()
                        .tag(0)
                }

                // Back Image
                if let backImage = viewModel.BackImage {
                    Image(uiImage: backImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300) // Adjust the size to make it a square
                    // Add shadow
                        .padding()
                        .tag(1)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always)) // Show dots below
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
            .frame(width: 300, height: 300)
            .background(Color.gray.opacity(0.1)) // Light gray background
            .cornerRadius(15)
            .shadow(color: Color.black.opacity(0.1), radius: 7, x: 0, y: 4)// Adjust frame to contain the carousel and shadow
        }
        .onReceive(timer) { _ in
            withAnimation {
                currentIndex = (currentIndex + 1) % 2 // Cycle between 0 and 1
            }
        }
    }
}

#Preview {
    ImageCarousel()
}
