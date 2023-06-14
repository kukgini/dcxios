import os
import SwiftUI
import LocalAuthentication

@main
struct dcxiosApp: App {
    let logger = Logger(subsystem: "dcxios", category: "App")
    
    @StateObject private var model = ViewModel()
    @State var authorized = false
    @State var error: LocalizedError?
    @State var showError: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if authorized {
                ContentView()
                    .environmentObject(model)
            } else {
                Button(action: authorize) {
                    Text("Authorize")
                }
                .alert(isPresented: $showError, content: showAuthorizeFailedAlert)
            }
        }
    }
    
    func showAuthorizeFailedAlert() -> Alert {
        return Alert(title: Text(error?.errorDescription ?? "error is nil or no description."),
                     message: Text("\(error?.failureReason ?? "")"),
                     dismissButton: .default(Text("Dismiss")))
    }
    
    func authorize() {
        let context: LAContext = LAContext()
        context.evaluatePolicy(
            .deviceOwnerAuthenticationWithBiometrics,
            localizedReason: "Biometric authentication required.")
        { successed, error in
            if successed {
                self.authorized = true
            } else {
                logger.error("Biometric authentication failed. \(error)")
                self.error = ApplicationError.wrap(error!)
                self.showError = true
            }
        }
    }
}
