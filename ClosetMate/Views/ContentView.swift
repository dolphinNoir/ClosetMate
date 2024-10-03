import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

enum Tab: Hashable {
    case first, second, third
}

struct ContentView: View {
    @State private var selectedTab : Tab = .second
    
    var body: some View{
        TabView(selection: $selectedTab){
            PlannerView()
                .tabItem {
                    Label("Planner", systemImage: "square.stack.3d.up")
                }.tag(Tab.first)
            
            MyWardrobeView()
                .tabItem {
                    Label("Wardrobe", systemImage: "tshirt")
                }.tag(Tab.second)
            
            ProfileView(selectedTab: $selectedTab)
                .tabItem {
                    Label("Profile", systemImage: "person")
                }.tag(Tab.third)
        }
        .tint(.brandPrimary)
            
      
    }
}


#Preview {
    ContentView()
}
