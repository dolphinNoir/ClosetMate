import SwiftUI

struct BackupView: View {
    @Binding var selectedTab : Tab
    var body: some View {
        VStack(spacing: 50) {
            Text("In order to view portfolio stats, you must first add at least 3 items.")
                .multilineTextAlignment(.center)
                .padding(.horizontal, 50)
            
            ZStack {
                Rectangle()
                    .fill(.brandLightGray)
                    .clipShape(RoundedRectangle(cornerRadius: 5))
                
                Button(action: {
                    selectedTab = .second
                }, label: {
                    Text("Add Item")
                        .foregroundStyle(.brandPrimary)
                })
            }
            .frame(width: 150, height: 50)
        }
        .navigationTitle(Text("Portfolio"))
    }
}

#Preview {
    BackupView(selectedTab: .constant(.third))
}
