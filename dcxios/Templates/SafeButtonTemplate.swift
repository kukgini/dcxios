import SwiftUI

struct SafeButtonTemplate: View {
    var body: some View {
        Button {
            
        } label: {
            Text("Safe Button")
        }
        .buttonStyle(BorderlessButtonStyle())
            // buttonStyle needed to avoid SwiftUI bug:
            // https://stackoverflow.com/questions/63087817/strange-buttons-behaviour-in-a-list-swiftui
    }
}
