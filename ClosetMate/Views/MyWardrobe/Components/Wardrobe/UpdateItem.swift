import SwiftUI

struct UpdateItem: View {
    @Environment(\.dismiss) var dismiss  // To handle view dismissal after deletion
    @Bindable var Item: ClothingItem
    @EnvironmentObject var viewModel : MyWardrobeViewModel
    @State private var showAlert = false 
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 10) {

                    ImageCarousel(FrontImage: Item.frontImage!, BackImage: Item.backImage!)
                    
                    Spacer()

                    VStack(alignment: .leading) {
                        Section {
                            // Item Name Input Field
                            ItemNameField(itemName: $Item.itemName)

                            // Item Category Picker
                            ItemCategoryPickerField(selectedCategory: Binding($Item.itemCategory))

                            // Item Color Picker
                            ItemColorPickerField(selectedColor: Binding($Item.itemColor))

                            // Bought Price Input
                            ItemPriceInput(label: "Item Bought For", price: Binding(
                                get: { $Item.itemBoughtFor.wrappedValue.map { String($0) } ?? "" },
                                set: { newValue in $Item.itemBoughtFor.wrappedValue = Int(newValue) }
                            ))

                            // Current Value Input
                            ItemPriceInput(label: "Item Current Value", price: Binding(
                                get: { $Item.itemCurrentValue.wrappedValue.map { String($0) } ?? "" },
                                set: { newValue in $Item.itemCurrentValue.wrappedValue = Int(newValue) }
                            ))
                        }
                        .headerProminence(.increased)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 10)
            .toolbar {
                // Top-right delete button
                ToolbarItem(placement: .navigationBarLeading){
                    Text("\(Item.itemName)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .padding(.vertical, 15)
                        

                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showAlert = true
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.black)  // Black bin icon
                    }
                    .padding(.vertical, 15)
                }
            }
            // Show alert to confirm deletion
            .alert("Delete \(Item.itemName)?", isPresented: $showAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    viewModel.deleteItem(item: Item, modelContext: modelContext)
                    dismiss()
                }
            } message: {
                Text("Are you sure you want to delete \(Item.itemName)? This action cannot be undone.")
            }
        }
    }

}
