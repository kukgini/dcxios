import SwiftUI

struct ContentView: View {
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
