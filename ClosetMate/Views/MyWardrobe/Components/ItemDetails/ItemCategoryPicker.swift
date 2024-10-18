import SwiftUI

struct ItemCategoryPicker: View {
    @Binding var selectedCategory: ItemCategory?

    var body: some View {
        List {
            ForEach(ItemCategory.groupedCategories.keys.sorted(), id: \.self) { group in
                Section(header: Text(group)) {
                    ForEach(ItemCategory.groupedCategories[group] ?? [], id: \.self) { category in
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
                }
            }
        }
        .navigationTitle("Select Category")
    }
}
