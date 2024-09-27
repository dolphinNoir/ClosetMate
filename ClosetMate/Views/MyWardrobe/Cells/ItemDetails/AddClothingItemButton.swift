//
//  AddItemButton.swift
//  ClosetMate
//
//  Created by johnny basgallop on 27/09/2024.
//

import SwiftUI
import SwiftData

struct AddClothingItemButton: View {
    var isFormValid: Bool
    var itemName: String
    var selectedCategory: ItemCategory?
    var selectedColor: ItemColor?
    var itemBoughtFor: String
    var itemCurrentValue: String
    @Binding var showAlert: Bool
    var context: ModelContext
    var onSubmit: () -> Void

    var body: some View {
        Button(action: {
            if isFormValid {
                onSubmit()
            } else {
                showAlert = true
            }
        }) {
            Text("Add Item")
                .frame(maxWidth: .infinity)
                .padding()
                .background(isFormValid ? Color.brandPrimary : Color.gray)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
        }
        .disabled(!isFormValid)
    }
}
