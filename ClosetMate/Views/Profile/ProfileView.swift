//
//  ProfileView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 11/09/2024.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("Welcome to your Profile")
            }.navigationTitle(Text("Profile"))
        }
    }
}

#Preview {
    ProfileView()
}
