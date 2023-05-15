import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        Group {
            switch model.currentView {
            case .dcx001: DCX001()
            case .dcx002: DCX002()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
