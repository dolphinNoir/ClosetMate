//
//  ItemPriceInput.swift
//  ClosetMate
//
//  Created by johnny basgallop on 27/09/2024.
//

import SwiftUI

struct ItemPriceInput: View {
    var label: String
    @Binding var price: String

    var body: some View {
        HStack(spacing: 15) {
            TextField(label, text: $price)
                .keyboardType(.numberPad)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
            
            Text("£")
                .font(.title2)
                .foregroundColor(.white)
                .padding(15)
                .background(Color(.brandPrimary))
                .clipShape(Circle())
        }
    }
}
