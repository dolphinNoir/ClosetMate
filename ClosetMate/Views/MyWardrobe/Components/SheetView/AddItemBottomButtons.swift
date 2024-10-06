import SwiftUI

struct AddItemBottomButtons: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MyWardrobeViewModel
    var isReadyForNext: Bool
    var leftTitle: String
    var rightTitle: String
    @Binding var navigationPath : NavigationPath

    var body: some View {
        HStack(spacing: 10) {
            Button(action: {
                navigationPath = NavigationPath()
                dismiss()
            }, label: {
                ZStack {
                    Rectangle()
                        .frame(width: (screenWidth - 75) * 0.35, height: 50)
                        .foregroundStyle(.brandLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    Text("\(leftTitle)")
                        .font(.caption)
                        .foregroundStyle(.brandPrimary)
                        .fontWeight(.semibold)
                }
            })
            
            Button(action: {
                viewModel.isLoading = true // Run the image conversion asynchronously and then navigate
                viewModel.ConvertImages()
                
            }, label: {
                ZStack {
                    Rectangle()
                        .frame(width: (screenWidth - 75) * 0.65, height: 50)
                        .foregroundStyle(viewModel.FrontImage == nil || viewModel.BackImage == nil ? .brandAccent : .brandPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    Text("\(rightTitle)")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
            })
            .disabled(viewModel.FrontImage == nil || viewModel.BackImage == nil)
        }
        // Use the new .navigationDestination modifier
        .navigationDestination(isPresented: $viewModel.ImagesAreConverted) {
            ItemDetails(navigationPath: $navigationPath).environmentObject(viewModel)
        }
    }
}
