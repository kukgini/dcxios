import SwiftUI
import LocalAuthentication

struct ExampleBiometricAuth: View {
    @State var authorized = false
    @State var error: Error?
    @State var showError: Bool = false
    
    var body: some View {
        Group {
            if authorized {
                Text("Authorized!")
            } else {
                Button(action: authorize) {
                    Text("Authorize")
                }
                .alert(isPresented: $showError, content: {
                    alertError(err: $error)
                })
            }
        }
    }
    
    func authorize() {
        let context: LAContext = LAContext()
        context.evaluatePolicy(
            .deviceOwnerAuthentication,
            localizedReason: "기기 인증이 필요합니다.")
        { successed, error in
            if successed {
                self.authorized = true
            } else {
                self.error = ApplicationError.wrap(error!)
                self.showError = true
            }
        }
    }
}
