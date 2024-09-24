//
//  SwiftUIView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 23/09/2024.
//

import SwiftUI

struct ItemDetails: View {
    @EnvironmentObject var viewModel : MyWardrobeViewModel
    var body: some View {
        VStack{
            if viewModel.isLoading{
                Text("Removing background")
                ProgressView()
            }

            else{
                if let front = viewModel.FrontImage {
                    Image(uiImage: front)
                        .resizable()
                        .scaledToFit()
                }
            }
        }.onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                print("is there a front: \(viewModel.FrontImage != nil)")
                print("is there a back: \(viewModel.BackImage != nil)")
                print("the loading state is: \(viewModel.isLoading)")
                viewModel.ConvertImages()
            }
            
        }
    
    }
}

#Preview {
    ItemDetails()
}
