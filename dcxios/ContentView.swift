import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        switch model.currentView {
        case .dcx001: DCX001(isExpanded: true)
        case .dcx002: DCX002()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
