import Foundation
import SwiftUI

struct ExampleChatView: View {    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    ForEach(1..<20) { index in
                        if index % 2 != 0 {
                            ChatItemView(alignment: .left, title: "Title \(index)", description: "BlaBla... \(index)")
                        } else {
                            ChatItemView(alignment: .right, title: "Title \(index)", description: "BlaBla... \(index)")
                        }
                    }
                }
                .navigationBarTitle("ExampleChatView")
                .navigationBarItems(
                    leading: Text("A"),
                    trailing: Text("B"))
            }
        }
    }
}
