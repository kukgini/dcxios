// ViewChangeButton.swift

import SwiftUI

struct ViewChangeButton: View {
    @EnvironmentObject var model: ViewModel
    
    var label: String
    var view: DCXView
    
    var body: some View {
        Button(action: {
            model.currentView = view
        }) {
            Text(label)
        }
    }
}

struct ViewChangeButton_Previews: PreviewProvider {
    static var previews: some View {
        ViewChangeButton(label:"Preview", view: .dcx001)
            .environmentObject(ViewModel())
    }
}
