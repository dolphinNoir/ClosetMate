//
//  ContentView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 10/09/2024.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

struct ContentView: View {
    init() {
        let appearance = UITabBarAppearance()
        
        appearance.stackedLayoutAppearance.normal.iconColor = UIColor.lightGray

        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.lightGray]
    }
    
    var body: some View{
        TabView{
            PlannerView()
                .tabItem {
                    Label("Planner", systemImage: "square.stack.3d.up")
                }
            
            MyWardrobeView()
                .tabItem {
                    Label("Wardrobe", systemImage: "tshirt")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
        .tint(.brandPrimary)
            
      
    }
}


#Preview {
    ContentView()
}
