import Foundation
import SwiftUI

enum ListItemAlignment {
    case left
    case right
}

struct ChatItemView: View {
    var alignment: ListItemAlignment
    var title: String
    var description: String
    
    var body: some View {
        switch alignment {
        case .left:
            HStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.subheadline)
                    Text(description)
                        .font(.caption)
                }
                Spacer()
            }
            .background(Color.green)
        case .right:
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(title)
                        .font(.subheadline)
                    Text(description)
                        .font(.caption)
                }
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundColor(.accentColor)
            }
            .background(Color.yellow)
        }

    }
}


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
