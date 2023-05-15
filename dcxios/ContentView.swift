import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        DCX001()
            .environmentObject(model)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ViewModel())
    }
}
