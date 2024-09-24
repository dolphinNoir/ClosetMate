//
//  AddItemGuidlines.swift
//  ClosetMate
//
//  Created by johnny basgallop on 24/09/2024.
//

import SwiftUI

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
    Guidlines()
}
