import SwiftUI

struct DetailsInput: View {
    @State private var itemName: String = ""
    @State private var selectedCategory: ItemCategory? = nil
    @State private var selectedColor: ItemColor? = nil
    @State private var itemBoughtFor: String = ""
    @State private var itemCurrentValue: String = ""
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MyWardrobeViewModel

    // State to show an alert if inputs are invalid
    @State private var showAlert = false

    // Computed property to check if the inputs are valid
    private var isFormValid: Bool {
        return !itemName.isEmpty && selectedCategory != nil && selectedColor != nil
    }

    var body: some View {
        VStack(spacing: 20) {
            ItemNameField(itemName: $itemName) // Item Name Input Field

            ItemCategoryPickerField(selectedCategory: $selectedCategory) // Item Category Picker

            ItemColorPickerField(selectedColor: $selectedColor) // Item Color Picker

            ItemPriceInput(label: "Item Bought For", price: $itemBoughtFor) // Bought Price Input

            ItemPriceInput(label: "Item Current Value", price: $itemCurrentValue) // Current Price Input

            Spacer()

            AddClothingItemButton(
                isFormValid: isFormValid,
                itemName: itemName,
                selectedCategory: selectedCategory,
                selectedColor: selectedColor,
                itemBoughtFor: itemBoughtFor,
                itemCurrentValue: itemCurrentValue,
                showAlert: $showAlert,
                context: modelContext
            ) {
                viewModel.addClothingItem(
                    itemName: itemName,
                    itemCategory: selectedCategory!,
                    itemColor: selectedColor!,
                    itemBoughtFor: Int(itemBoughtFor) ?? 0,
                    itemCurrentValue: Int(itemCurrentValue) ?? 0,
                    context: modelContext
                )
                dismiss()
            }
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Missing Information"),
                message: Text("Please fill in all the required fields."),
                dismissButton: .default(Text("OK"))
            )
        }
        .padding()
    }
}




// Preview
struct ClothingItemForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsInput().environmentObject(MyWardrobeViewModel())
        }
    }
}
