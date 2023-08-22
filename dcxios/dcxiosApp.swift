import os
import SwiftUI

@main
struct dcxiosApp: App {
    @StateObject private var appStates = ApplicationStates.singleton
    @State var authorized = false
    @State var error: LocalizedError?
    @State var showError: Bool = false
    
    var body: some Scene {
        WindowGroup {
                ContentView().environmentObject(appStates)
        }
    }
}
