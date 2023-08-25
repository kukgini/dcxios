import SwiftUI

struct ListViewTemplate: View {
    @EnvironmentObject var viewStates: ApplicationStates
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        SearchBar(complition: { newNameFilter in
                            print("searching... \(newNameFilter)")
                        })
                    }
                    HStack(alignment: .center) {
                        SafeButtonTemplate()
                    }
                    Spacer()
                }
                List {
                    
                }
                .offset(y: 90)
                .listStyle(.plain)
            }
            .navigationBarTitle("View1")
            .navigationBarItems(
                leading: Text("A"),
                trailing: Text("B"))
        }
    }
}
