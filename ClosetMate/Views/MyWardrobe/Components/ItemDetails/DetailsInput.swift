import SwiftUI
import SwiftData

struct DetailsInput: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: MyWardrobeViewModel
    
    @Binding var navigationPath : NavigationPath
    @State private var itemName: String = ""
    @State private var selectedCategory: ItemCategory? = nil
    @State private var selectedColor: ItemColor? = nil
    @State private var itemBoughtFor: String = ""
    @State private var itemCurrentValue: String = ""
    @State private var showAlert = false
    
    private var isFormValid: Bool {
        return !itemName.isEmpty && selectedCategory != nil && selectedColor != nil
    }
    
    var body: some View {
        VStack(spacing: 20) {
            ItemNameField(itemName: $itemName)
            
            ItemCategoryPickerField(selectedCategory: $selectedCategory)
            
            ItemColorPickerField(selectedColor: $selectedColor)
            
            ItemPriceInput(label: "Item Bought For", price: $itemBoughtFor)
            
            ItemPriceInput(label: "Item Current Value", price: $itemCurrentValue)
            
            Spacer().frame(height: 20)
            
            Button(action: {
                if isFormValid {
                    viewModel.addClothingItem(
                        itemName: itemName,
                        itemCategory: selectedCategory!,
                        itemColor: selectedColor!,
                        itemBoughtFor: Int(itemBoughtFor)!,
                        itemCurrentValue: Int(itemCurrentValue)!,
                        context: modelContext
                    )
                    
                    navigationPath.removeLast(navigationPath.count)
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
            .disabled(!isFormValid)
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
