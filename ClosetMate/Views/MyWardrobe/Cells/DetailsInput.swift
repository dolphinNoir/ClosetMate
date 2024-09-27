import SwiftUI

struct DetailsInput: View {
    @State private var itemName: String = ""
    @State private var selectedCategory: ItemCategory? = nil
    @State private var selectedColor: ItemColor? = nil
    @State private var itemBoughtFor: String = ""
    @State private var itemCurrentValue: String = ""

    var body: some View {
        VStack(spacing: 20) {
            // Item Name
            TextField("Item Name", text: $itemName)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal)

            // Item Category Picker
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

            // Item Color Picker
            NavigationLink(destination: ItemColorPicker(selectedColor: $selectedColor)) {
                HStack {
                    Text("Item Color")
                    Spacer()
                    Text(selectedColor?.rawValue ?? "Select")
                        .foregroundColor(.gray)
                    
                    if let selectedColor {
                        Rectangle()
                            .fill(Color(hex: selectedColor.rawValue))
                            .frame(width: 30, height: 30)
                            .cornerRadius(5)
                    }
                  
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(.systemGray6))
                .foregroundStyle(.brandPrimary)
                .cornerRadius(10)
                .padding(.horizontal)
            }

            // Item Bought For
            HStack(spacing: 15) {
                TextField("Item Bought For", text: $itemBoughtFor)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .foregroundStyle(.brandPrimary)
                    .cornerRadius(10)
                
                Text("£")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color(.brandPrimary))
                    .clipShape(Circle())
            }
            .padding(.horizontal)

            // Item Current Value
            HStack(spacing: 15){
                TextField("Item Current Value", text: $itemCurrentValue)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Text("£")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(15)
                    .background(Color(.brandPrimary))
                    .clipShape(Circle())
            }
            .padding(.horizontal)

            Spacer()
        }
    }
}

struct ItemCategoryPicker: View {
    @Binding var selectedCategory: ItemCategory?

    var body: some View {
        List(ItemCategory.allCases, id: \.self) { category in
            HStack {
                Text(category.rawValue)
                Spacer()
                if category == selectedCategory {
                    Image(systemName: "checkmark")
                        .foregroundColor(.blue)
                }
            }
            .contentShape(Rectangle())
            .onTapGesture {
                selectedCategory = category
            }
        }
        .navigationTitle("Select Category")
    }
}

struct ItemColorPicker: View {
    @Binding var selectedColor: ItemColor?

    var body: some View {
        List(ItemColor.allCases, id: \.self) { color in
                HStack {
                    Text("\(color.rawValue)")
                    Spacer()
                    Rectangle()
                        .fill(Color(hex: color.rawValue))
                        .frame(width: 30, height: 30)
                        .cornerRadius(5)
                    if color == selectedColor {
                        Image(systemName: "checkmark")
                            .foregroundColor(.brandPrimary)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedColor = color
                }
            }
            .navigationTitle("Select Color")
        }
}

// MARK: - Helper Function to Convert Hex to SwiftUI Color
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let r, g, b: Double
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b) = (Double((int >> 16) & 0xFF), Double((int >> 8) & 0xFF), Double(int & 0xFF))
        default:
            (r, g, b) = (1, 1, 1)
        }
        self.init(
            .sRGB,
            red: r / 255,
            green: g / 255,
            blue: b / 255,
            opacity: 1.0
        )
    }
}

// Preview
struct ClothingItemForm_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailsInput()
        }
    }
}
