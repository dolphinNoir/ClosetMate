//
//  TopColorsCard.swift
//  ClosetMate
//
//  Created by johnny basgallop on 02/10/2024.
//

import SwiftUI

struct TopColorsCard: View {
    var topColors: [(color: ItemColor, count: Int)]
    
    var body: some View {
        VStack(alignment:.leading, spacing: 20) {
            HStack {
                Text("Favourite Colors")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.horizontal, 20)
            
            HStack(spacing: 20) {
                ForEach(topColors, id: \.color) { color, count in
                    VStack {
                        // Rectangle showing the color
                        Rectangle()
                            .fill(Color(hex: color.rawValue))
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.black.opacity(0.1), lineWidth: 1)
                            )
//                        Text(color.rawValue)
//                            .font(.caption2)
//                            .foregroundColor(.brandAccent)
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .frame(width: (screenWidth - 45), height: 150)
        .background(Color(.systemGray6))
        .cornerRadius(15)
        .padding(.vertical, 10)
    }
}

#Preview {
    TopColorsCard(topColors: [(ItemColor.red, 3), (ItemColor.blue, 6), (ItemColor.green, 2), (ItemColor.black, 4)])
}
