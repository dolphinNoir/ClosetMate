import SwiftUI

struct AddItemButton: View {
    @Binding var SheetIsPresented : Bool
    @Binding var navigationPath : NavigationPath
    var body: some View {
        Button(action: {
            navigationPath.removeLast(navigationPath.count)
            navigationPath = NavigationPath()
            SheetIsPresented.toggle()
        }, label: {
            Image(systemName: "plus")
                .foregroundStyle(.brandPrimary)
                .font(.system(size: 18))
                .frame(width: 50, height: 50)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.08), radius: 2, x: 0, y: 4)
            
        }).offset(x:-5, y: -50)
    }
}

#Preview {
    AddItemButton(SheetIsPresented: .constant(false), navigationPath: .constant(NavigationPath()))
}
