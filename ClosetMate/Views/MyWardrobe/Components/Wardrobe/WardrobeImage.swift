import SwiftUI

struct WardrobeImage: View {
    var image: UIImage?
    var width: CGFloat = 150
    var height: CGFloat = 150
    var name : String?
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.brandLightGray)
                    .frame(width: width, height: height)
                
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: width - 30, height: height - 30)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .padding(35)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: width - 10, height: height - 10)
                        .foregroundColor(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            .frame(width: width, height: height)
            .background(.brandLightGray)
            .clipShape(RoundedRectangle(cornerRadius: 15))
            .shadow(color: Color.black.opacity(0.1), radius: 7, x: 0, y: 4)
            
            if let text = name {
                Text(text)
                    .font(.footnote)
                    .foregroundStyle(.brandAccent)
                    .fontWeight(.medium)
                    .padding(.top, 5)
                    .frame(width: width - 10)
                    .lineLimit(1)
            }
            
        }
    }
}

#Preview {
    WardrobeImage(image: UIImage(imageLiteralResourceName: "FrontOfBrownHoodie"))
}

#Preview {
    WardrobeImage(image: UIImage(imageLiteralResourceName: "FrontOfBrownHoodie")).environmentObject(MyWardrobeViewModel())
}
