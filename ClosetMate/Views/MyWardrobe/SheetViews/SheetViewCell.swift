//
//  SheetViewCell.swift
//  ClosetMate
//
//  Created by johnny basgallop on 19/09/2024.
//

import SwiftUI

struct SheetViewCell: View {
    @EnvironmentObject var viewModel : MyWardrobeViewModel
    var body: some View {
        NavigationStack{
            VStack (spacing: 25){
                Spacer()
                
                VStack(alignment: .leading){
                    Text("Scan Item")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    
                    Text("First we need to scan your item so we can display it visually in the wardrobe, and you can plan outfits with it")
                        .foregroundStyle(.brandAccent)
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                
                HStack(spacing:10){
                    ScanBox(title: "Front", onClick: {
                        print("clicked front")
                    } ).environmentObject(viewModel)
                    
                    ScanBox(title: "Back", onClick: {
                        print("clicked Back")
                    } ).environmentObject(viewModel)
                }
                
                Guidlines()
                
                Spacer()
                
                AddItemBottomButtons(isReadyForNext: false, leftTitle: "Cancel", rightTitle: "Next Step").environmentObject(viewModel)
                
                
            }.padding(.horizontal, 20)
        }
    }
}


//
//  SheetCancelAndNextButtons.swift
//  ClosetMate
//
//  Created by johnny basgallop on 20/09/2024.
//











#Preview {
    SheetViewCell()
}
