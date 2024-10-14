import SwiftUI
import TipKit
import SwiftData


@main
struct YourApp: App {
  var body: some Scene {
    WindowGroup {
          SplashScreenView()
              .task {
                  try? Tips.resetDatastore()
                  try? Tips.configure([
                    .displayFrequency(.immediate),
                    .datastoreLocation(.applicationDefault)
                  ])
              }.preferredColorScheme(.light)
    }.modelContainer(for: [ClothingItem.self])
  }
}
