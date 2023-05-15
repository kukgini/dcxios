// DCX002.swift

import SwiftUI

struct DCX002: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        NavigationView {
            List {
                Text(model.greeting)
            }
            .navigationBarTitle("Sub View")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: DCX002BackButton(),
                trailing: Text("B"))
        }
    }
}

struct DCX002BackButton: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        Button(action: {
            model.currentView = .dcx001
        }) {
            Text("<")
        }
    }
}

struct DCX002_Previews: PreviewProvider {
    static var previews: some View {
        DCX002()
            .environmentObject(ViewModel())
    }
}
