//
//  SplashScreenView.swift
//  ClosetMate
//
//  Created by johnny basgallop on 10/09/2024.
//

import SwiftUI


struct SplashScreenView: View {
    @State private var isMain = false
    
      var body: some View {
          if isMain {
              ContentView()
          }
          
          else{
              SplashScreen(isMain: $isMain)
          }
          
      }
}

struct SplashScreen : View {
    @State private var isFavorite = true
    @State private var Opacity : CGFloat = 0.2
    @Binding var isMain : Bool
    
      var body: some View {
          VStack{
              Spacer()
          HStack{
                  Image(systemName: isFavorite ? "tshirt.fill": "tshirt.circle.fill")
                  .scaleEffect(isFavorite ? 1.0 : 1.3)
                  
                  .contentTransition(.symbolEffect(.replace.downUp))
                  

              Text("ClosetMate").font(.system(size: 35, weight: .semibold, design: .rounded))
                  .padding(.horizontal, 5)
              
          }
          .offset(x:0, y:-30)
          .font(.largeTitle)
          .onAppear{
              
              withAnimation(.easeInOut(duration: 0.3)){
                  Opacity = 1.0
              }
              
              
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                  isFavorite.toggle()
              }
              
              DispatchQueue.main.asyncAfter(deadline: .now() + 2.5){
                  withAnimation(.easeInOut(duration: 0.3)){
                      Opacity = 0.2
                      isMain.toggle()
                  }
                  
               
              }
              
          }
              Spacer()
              Spacer()
          }.opacity(Opacity)
          
      }
}

#Preview {
    SplashScreenView()
}
