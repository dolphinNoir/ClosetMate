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
//                    viewModel.ConvertImages()
                }, label: {
                    NavigationLink(destination:ItemDetails().environmentObject(viewModel)){
                        ZStack{
                            Rectangle()
                                .frame(width: (screenWidth - 75) * 0.65, height: 50)
                                .foregroundStyle(viewModel.FrontImage == nil || viewModel.BackImage == nil ? .brandAccent : .brandPrimary)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                            
                            Text("\(rightTitle)")
                                .font(.caption)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                        }
                    }
                }).disabled(viewModel.FrontImage == nil || viewModel.BackImage == nil)
            
            
            
        }
    }
}

#Preview {
    AddItemBottomButtons(isReadyForNext: false, leftTitle: "Cancel", rightTitle: "NextStep")
}
