import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: dcxiosStates
    
    var body: some View {
//        View1(isExpanded: false)
        ExamplePopupView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(dcxiosStates.singleton)
    }
}
