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
                leading: ViewChangeButton(label: "<", view: .dcx001),
                trailing: Text("B"))
        }
    }
}

struct DCX002_Previews: PreviewProvider {
    static var previews: some View {
        DCX002()
            .environmentObject(ViewModel())
    }
}
