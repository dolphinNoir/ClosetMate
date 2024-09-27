import SwiftUI

struct ItemCategoryPickerField: View {
    @Binding var selectedCategory: ItemCategory?

    var body: some View {
        NavigationLink(destination: ItemCategoryPicker(selectedCategory: $selectedCategory)) {
            HStack {
                Text("Item Category")
                Spacer()
                Text(selectedCategory?.rawValue ?? "Select")
                    .foregroundColor(.gray)
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
