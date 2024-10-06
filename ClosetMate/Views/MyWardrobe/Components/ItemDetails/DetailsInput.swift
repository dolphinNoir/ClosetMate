import SwiftUI
import SwiftData

struct DetailsInput: View {
    @Binding var navigationPath : NavigationPath
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
            
            Spacer().frame(height: 20)

            Button(action: {
                if isFormValid {
                    // Add the clothing item to the view model
                    viewModel.addClothingItem(
                        itemName: itemName,
                        itemCategory: selectedCategory!,
                        itemColor: selectedColor!,
                        itemBoughtFor: Int(itemBoughtFor)!,
                        itemCurrentValue: Int(itemCurrentValue)!,
                        context: modelContext
                    )
                    
                    // Dismiss both the current and parent sheets
                    navigationPath.removeLast(navigationPath.count)  // Reset the navigation state
                    viewModel.closeOutSheet()
                   
                    
                } else {
                    showAlert = true
                }
            }) {
                Text("Add Item")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(isFormValid ? Color.brandPrimary : Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(5)
            }
            .disabled(!isFormValid)  // Disable button if the form is not valid
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Missing Information"),
                    message: Text("Please fill in all the fields."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
        .padding()
    }
    
}

#Preview {
    DetailsInput(navigationPath: .constant(NavigationPath()))
}
