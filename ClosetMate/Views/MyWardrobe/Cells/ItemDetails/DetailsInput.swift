import SwiftUI

struct DetailsInput: View {
    @State private var itemName: String = ""
    @State private var selectedCategory: ItemCategory? = nil
    @State private var selectedColor: ItemColor? = nil
    @State private var itemBoughtFor: String = ""
    @State private var itemCurrentValue: String = ""
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss// Track the presentation mode for dismissing
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

            Button(action: {
                if isFormValid {
                    // Add the clothing item to the view model
                    viewModel.addClothingItem(
                        itemName: itemName,
                        itemCategory: selectedCategory!,
                        itemColor: selectedColor!,
                        itemBoughtFor: Int(itemBoughtFor) ?? 0,
                        itemCurrentValue: Int(itemCurrentValue) ?? 0,
                        context: modelContext
                    )
                    
                    // Dismiss both the current and parent sheets
                    viewModel.closeOutSheet()
                    dismiss()
                    
                } else {
                    showAlert = true
                }
            }) {
                Text("Add Item")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.brandPrimary : Color.gray) // Change button color based on form validity
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
            .disabled(!isFormValid)  // Disable button if the form is not valid
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("Please fill in all the required fields."),
                    dismissButton: .default(Text("OK"))
                )
            }
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
