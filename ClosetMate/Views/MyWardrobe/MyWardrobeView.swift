//
//  MyWardrobeView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 11/09/2024.
//

import SwiftUI

struct MyWardrobeView: View {
    var body: some View {
            VStack {
                HStack{
                    Text("Your Wardrobe").font(.system(size: 30, weight: .semibold))
                    Spacer()
                    Image(systemName: "magnifyingglass").font(.system(size: 20))
                }
                
                Spacer()
                
                Text("It Appears You Dont Have Any Items To Show, Click the Add Button to begin your collection.").font(.system(size: 15)).multilineTextAlignment(.center).frame(width: screenWidth / 1.5)
                
                Spacer()
                
            }.padding(.horizontal, 20)
        }
}

#Preview {
    MyWardrobeView()
}
