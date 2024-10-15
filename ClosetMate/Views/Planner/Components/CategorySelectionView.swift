//
//  CategorySelctionView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 06/10/2024.
//

import SwiftUI

struct CategorySelectionView: View {
    @Binding var selectedCategory: ItemCategory
    var categories: [ItemCategory]
    var numberOfItems: Int
    
    var body: some View {
        HStack{
            Menu {
                ForEach(categories, id: \.self) { category in
                    Button(action: {
                        selectedCategory = category
                    }) {
                        Text(category.rawValue)
                    }
                }
            } label: {
                Text(selectedCategory.rawValue)
                    .font(.footnote)
                    .foregroundColor(.brandPrimary)
                    .padding(5)
                    .background(RoundedRectangle(cornerRadius: 5).stroke(.brandPrimary, lineWidth: 1))
            }
            
            Spacer()
            
            Text("(\(numberOfItems))").font(.caption2).foregroundStyle(.brandAccent)
        }
        .padding(.horizontal)
    }
}

