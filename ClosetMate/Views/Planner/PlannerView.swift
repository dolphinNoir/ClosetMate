//
//  DiscoverView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 11/09/2024.
//

import SwiftUI

struct PlannerView: View {
    var body: some View {
        NavigationStack{
            VStack{
                Text("welcome to the outfit planner")
            }.navigationTitle(Text("Outfit Planner"))
        }
    }
}

#Preview {
    PlannerView()
}
