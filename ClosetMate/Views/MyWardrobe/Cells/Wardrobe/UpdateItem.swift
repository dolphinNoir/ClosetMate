//
//  UpdateItem.swift
//  ClosetMate
//
//  Created by johnny basgallop on 28/09/2024.
//

import SwiftUI

struct UpdateItem: View {
    @Bindable var Item : ClothingItem
    var body: some View {
        Text(Item.itemName)
    }
}


