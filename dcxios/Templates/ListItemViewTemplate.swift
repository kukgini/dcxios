import SwiftUI

struct ListItemViewTemplate: View {
    var body: some View {
        HStack {
            VStack (alignment: .leading, spacing: 0){
                HStack {
                    Text("Item Name")
                    Image(systemName: "star.fill")
                    Spacer() // need for left alignment
                }
                HStack {
                    Text(String("Description"))
                    Text(String("Sub Description"))
                    Spacer() // need for left alignment
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}
