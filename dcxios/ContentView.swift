import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    var body: some View {
        ExampleShopView()
//        ExampleChatView()
//        ExamplePopupView()
//        ExampleRestClientView()
//        ExampleCustomDisclosureGroupView(isExpanded: true)
//        ExampleBiometricAuth()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ApplicationStates.singleton)
    }
}
