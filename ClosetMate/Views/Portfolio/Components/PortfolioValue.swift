import SwiftUI

struct PortfolioValue: View {
    var title: String
    var value: String
    var valueColor: Color = .primary
    var body: some View {
        VStack(spacing: 20){
            HStack{
                Text(title)
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack{
                Text(value)
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(valueColor)
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .frame(width: (screenWidth - 45), height: 130)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.vertical, 10)
    }
}

#Preview {
    PortfolioValue(title: "Wardrobe Value", value: "100")
}
