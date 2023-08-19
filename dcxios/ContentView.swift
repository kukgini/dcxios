import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appStates: dcxiosStates
    
    var body: some View {
        View1()
//        ExampleChatView()
//        ExamplePopupView()
//        ExampleRestClientView()
//        ExampleCustomDisclosureGroupView(isExpanded: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(dcxiosStates.singleton)
    }
}
