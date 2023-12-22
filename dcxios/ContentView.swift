import os
import SwiftUI

struct ContentView: View {
    private let logger: Logger
    
    init() {
        self.logger = Logger(
            subsystem: Bundle.main.bundleIdentifier!,
            category: String(describing: type(of: self))
        )
    }
    
    @EnvironmentObject var appStates: ApplicationStates
    
    var body: some View {
        ExampleShopView().environmentObject(ExampleShopStates.singleton)
//        ExampleChatView()
//        ExamplePopupView()
//        ExampleRestClientView()
//        ExampleCustomDisclosureGroupView(isExpanded: true)
//        ExampleBiometricAuth()
    }
}
