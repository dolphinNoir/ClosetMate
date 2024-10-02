//
//  TopCategoriesGrid.swift
//  ClosetMate
//
//  Created by johnny basgallop on 02/10/2024.
//

import SwiftUI

struct TopCategoriesGrid: View {
    var topCategories: [(category: ItemCategory, count: Int)]
    
    // Define a two-column grid layout
    let columns = [
        GridItem(.flexible(), spacing: 20),
        GridItem(.flexible(), spacing: 20)
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Top 3 Categories")
                    .font(.headline)
                    .foregroundColor(.gray)
                Spacer()
            }
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(topCategories, id: \.category) { category, count in
                    CategoryCard(category: category, count: count)
                }
            }
        }
        .padding()
        .cornerRadius(15)
        .padding(.vertical, 10)
    }
}

// MARK: - Individual Category Card
struct CategoryCard: View {
    var category: ItemCategory
    var count: Int
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .fill(.brandLightGray)
                .frame(width: (screenWidth - 80) / 2, height: 150)
                .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 4)
            
            VStack(spacing: 10) {
                Text(category.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity)  // Make sure text fits within the card
                
                Text("\(count)")
                    .font(.title3)
                    .foregroundColor(.brandPrimary)
            }
            .padding()
        }
    }
}
#Preview {
    TopCategoriesGrid(topCategories: [(ItemCategory.hoodie, 5), (ItemCategory.blazer, 3), (ItemCategory.trousers, 4), (ItemCategory.jeans, 8)])
}
