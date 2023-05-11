import SwiftUI

@main
struct dcxiosApp: App {
    @StateObject private var model = ModelData()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
