//
//  ItemNameField.swift
//  ClosetMate
//
//  Created by johnny basgallop on 27/09/2024.
//

import SwiftUI

struct ItemNameField: View {
    @Binding var itemName: String

    var body: some View {
        TextField("Item Name", text: $itemName)
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(10)
    }
}

