//
//  ItemColorPicker.swift
//  ClosetMate
//
//  Created by johnny basgallop on 27/09/2024.
//

import SwiftUI


struct ItemColorPicker: View {
    @Binding var selectedColor: ItemColor?

    var body: some View {
        List(ItemColor.allCases, id: \.self) { color in
                HStack {
                    Text("\(color.rawValue)")
                    Spacer()
                    Rectangle()
                        .fill(Color(hex: color.rawValue))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                    if color == selectedColor {
                        Image(systemName: "checkmark")
                            .foregroundColor(.brandPrimary)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedColor = color
                }
            }
            .navigationTitle("Select Color")
        }
}


