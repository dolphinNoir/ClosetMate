//
//  SheetViewCell.swift
//  ClosetMate
//
//  Created by johnny basgallop on 19/09/2024.
//

import SwiftUI
import TipKit

struct SheetViewCell: View {
    @EnvironmentObject var viewModel : MyWardrobeViewModel
    @Binding var navigationPath : NavigationPath
    let ScanTip = ScanningAdviceTip()
    
    
    var body: some View {
        NavigationStack(path: $navigationPath){
            Spacer()
            
            VStack(alignment: .leading, spacing: 30){
                VStack(alignment: .leading){
                    Text("Scan Item")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, 5)
                    
                        Text("First we need to scan your item so we can display it.")
                            .foregroundStyle(.brandAccent)
                            .font(.callout)
                            .fixedSize(horizontal: false, vertical: true)
                }
                
                
                VStack(spacing:25){
                    ScanBox(title: "Front", onClick: {
                        print("clicked front")
                    } ).environmentObject(viewModel)
                        .popoverTip(ScanTip)
                    
                    ScanBox(title: "Back", onClick: {
                        print("clicked Back")
                    } ).environmentObject(viewModel)
                }
                
                Spacer()
                
                    AddItemBottomButtons(isReadyForNext: false, leftTitle: "Cancel", rightTitle: "Next Step", navigationPath: $navigationPath)
                    .environmentObject(viewModel)

                
            }
            .padding(20)
        }
    }
}


#Preview {
    SheetViewCell(navigationPath: .constant(NavigationPath())).environmentObject(MyWardrobeViewModel())
        .task {
            try? Tips.resetDatastore()
            try? Tips.configure([
                .displayFrequency(.immediate),
                .datastoreLocation(.applicationDefault)
            ])
        }
}
