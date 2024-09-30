//
//  AddItemButton.swift
//  ClosetMate
//
//  Created by johnny basgallop on 19/09/2024.
//

import SwiftUI

struct AddItemButton: View {
    @Binding var SheetIsPresented : Bool
    
    var body: some View {
            Button(action: {
                SheetIsPresented.toggle()
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
}

#Preview {
    AddItemButton(SheetIsPresented: .constant(false))
}
