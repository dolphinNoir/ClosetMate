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
                
                HStack{
                    
                 Spacer()
                    
                    Button(action: {
                        
                    }, label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.brandPrimary)
                            .font(.system(size: 18))
                            .frame(width: 50, height: 50) // Size of the button
                            .background(Color.white) // Button background color
                            .clipShape(Circle()) // Make the button circular
                            .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 4)
                        
                    }).offset(x:-5, y: -50)
                    
                }
                
            }.padding(.horizontal, 20)
        }
}

#Preview {
    MyWardrobeView()
}
 
