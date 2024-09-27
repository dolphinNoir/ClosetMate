//
//  ItemColorPickerField.swift
//  ClosetMate
//
//  Created by johnny basgallop on 27/09/2024.
//

import SwiftUI

struct ItemColorPickerField: View {
    @Binding var selectedColor: ItemColor?

    var body: some View {
        NavigationLink(destination: ItemColorPicker(selectedColor: $selectedColor)) {
            HStack {
                Text("Item Color")
                Spacer()
                Text(selectedColor?.rawValue ?? "Select")
                    .foregroundColor(.gray)
                if let selectedColor {
                    Rectangle()
                        .fill(Color(hex: selectedColor.rawValue))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                }
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
            .background(Color(.systemGray6))
            .foregroundStyle(.brandPrimary)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}
