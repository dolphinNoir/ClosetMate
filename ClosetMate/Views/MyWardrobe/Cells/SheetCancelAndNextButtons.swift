//
//  SheetCancelAndNextButtons.swift
//  ClosetMate
//
//  Created by johnny basgallop on 20/09/2024.
//

import SwiftUI
import PhotosUI

struct SheetCancelAndNextButtons : View {
    @Environment(\.dismiss) var dismiss
    
    var isReadyForNext : Bool
    var leftTitle : String
    var rightTitle : String
    var onClickLeft : () -> Void
    var onClickRight : () -> Void
    
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
                onClickLeft()
            }, label: {
                ZStack{
                    Rectangle()
                        .frame(width: (screenWidth - 75) * 0.65, height: 50)
                        .foregroundStyle(isReadyForNext ? .brandPrimary : .brandAccent)
                        .clipShape(RoundedRectangle(cornerRadius: 5))
                        
                    Text("\(rightTitle)")
                        .font(.caption)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }
            })
        }
    }
}



#Preview {
    SheetCancelAndNextButtons(isReadyForNext: true, leftTitle: "Cancel", rightTitle: "Next Step", onClickLeft: {}, onClickRight: {})
}
