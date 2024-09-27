//
//  AddItemBottomButtons.swift
//  ClosetMate
//
//  Created by johnny basgallop on 25/09/2024.
//

import SwiftUI

struct AddItemBottomButtons : View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel : MyWardrobeViewModel
    var isReadyForNext : Bool
    var leftTitle : String
    var rightTitle : String

    
    var body: some View {
        HStack(spacing: 10){
            Button(action: {
                dismiss()
            }, label: {
                ZStack{
                    Rectangle()
                        .frame(width: (screenWidth - 75) * 0.35 , height: 50)
                        .foregroundStyle(.brandLightGray)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                    
                    Text("\(leftTitle)")
                        .font(.caption)
                        .foregroundStyle(.brandPrimary)
                        .fontWeight(.semibold)
                }
            })
            
            Button(action: {
                // Run the image conversion asynchronously and then navigate
                viewModel.ConvertImages()
                viewModel.isLoading = true // Optional: Set loading state if needed
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
            .background(
                // Use the background to handle navigation after the button is pressed
                NavigationLink(destination: ItemDetails().environmentObject(viewModel),
                               isActive: $viewModel.isLoading) {
                    EmptyView()
                }
            )
            
            
            
        }
    }
}

#Preview {
    AddItemBottomButtons(isReadyForNext: false, leftTitle: "Cancel", rightTitle: "NextStep")
}
