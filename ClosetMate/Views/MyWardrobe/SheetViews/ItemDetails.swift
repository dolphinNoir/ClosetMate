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
                ItemDetailsView().environmentObject(viewModel).padding(.horizontal, 10)
            }
        }
    }
}

struct ItemDetailsView : View {
    @EnvironmentObject var viewModel : MyWardrobeViewModel
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
            VStack(spacing: 10){
                VStack(alignment: .leading){
                    Text("Item Details")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.bottom, 6)
                    
                    Text("Brilliant, Next we need some information about the item.")
                        .foregroundStyle(.brandAccent)
                        .font(.callout)
                        .fixedSize(horizontal: false, vertical: true)
                }.padding(.bottom, 15)
                
                ImageCarousel().environmentObject(viewModel)
                Spacer()
                
                VStack(alignment: .leading){
                    Section() {
                        DetailsInput()
                    }.headerProminence(.increased)
                }
            
            }
        }
    }
}

#Preview {
    ItemDetails().environmentObject(MyWardrobeViewModel())
}
