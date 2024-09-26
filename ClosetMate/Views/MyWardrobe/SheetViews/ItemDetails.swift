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
                ItemDetailsView().environmentObject(viewModel)
            }
        }.onAppear{
                viewModel.ConvertImages()
        }
    
    }
}

struct ItemDetailsView : View {
    @EnvironmentObject var viewModel : MyWardrobeViewModel
    var body: some View {
        VStack(spacing: 0){
            ImageCarousel().environmentObject(viewModel)
            Spacer()
        }
    }
}

#Preview {
    ItemDetails()
}
