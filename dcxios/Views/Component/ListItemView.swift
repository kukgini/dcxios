
import SwiftUI

enum ListItemAlignment {
    case left
    case right
}

struct ListItemView: View {
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


struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView(alignment: .left, title: "Title", description: "Description")
        ListItemView(alignment: .right, title: "Title", description: "Description")
    }
}
