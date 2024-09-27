//
//  ItemCategoryPicker.swift
//  ClosetMate
//
//  Created by johnny basgallop on 27/09/2024.
//

import SwiftUI

struct ItemCategoryPicker: View {
    @Binding var selectedCategory: ItemCategory?

    var body: some View {
        List(ItemCategory.allCases, id: \.self) { category in
            HStack {
                Text(category.rawValue)
                Spacer()
                if category == selectedCategory {
                    Image(systemName: "checkmark")
                        .foregroundColor(.brandPrimary)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                selectedCategory = category
            }
        }
        .navigationTitle("Select Category")
    }
}

