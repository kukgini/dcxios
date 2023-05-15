import SwiftUI

@main
struct dcxiosApp: App {
    @StateObject private var model = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(model)
        }
    }
}
