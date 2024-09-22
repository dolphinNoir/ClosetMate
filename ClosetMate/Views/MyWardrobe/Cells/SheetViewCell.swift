//
//  SheetViewCell.swift
//  ClosetMate
//
//  Created by johnny basgallop on 19/09/2024.
//

import SwiftUI

struct SheetViewCell: View {
    var body: some View {
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
                } )
                
                ScanBox(title: "Back", onClick: {
                    print("clicked Back")
                } )
            }
            
            Guidlines()
            
            Spacer()
            
            SheetCancelAndNextButtons(isReadyForNext: false, leftTitle: "Cancel", rightTitle: "Next Step", onClickLeft: {}, onClickRight: {})
                
            
        }.padding(.horizontal, 20)
    }
}



struct Guidlines : View {
    var body: some View {
        VStack(alignment: .leading, spacing: 25){
            BulletedText(text: "Try to ensure item is laying flat and fully in frame, and avoid wrinkles")
            BulletedText(text: "Make sure the background of the photo is a different colour to the clothes")
            BulletedText(text: "Make sure the Front and Back scan of the item look around the same size")
            BulletedText(text: "Try to take the front and back photo from the same distance with similar lighting")
        }
        .padding(.horizontal, 10)
        .padding(.top, 10)
    }
}

struct BulletedText: View {
    var text: String
    var body: some View {
            HStack(alignment: .top, spacing: 5) {
                Text("•")
                    .font(.body)
                
                Text(text)
                    .font(.system(size: 14, weight: .regular))
                    .fixedSize(horizontal: false, vertical: true)  // Allow wrapping for long text
            }
        }
}



#Preview {
    SheetViewCell()
}
