// DCX001.swift

import SwiftUI

struct DCX001: View {
    @EnvironmentObject var model: ViewModel
    @State var isExpanded: Bool
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(model.greeting)
            
            List {
                ForEach(1..<20) { index in
                    if index % 2 != 0 {
                        ListItemView(alignment: .left, title: "Title \(index)", description: "BlaBla... \(index)")
                    } else {
                        ListItemView(alignment: .right, title: "Title \(index)", description: "BlaBla... \(index)")
                    }
                }
            }
            .listStyle(.plain)
            
            ViewChangeButton(label: "Go DCX002 View", view: .dcx002)
            Button(action: {
                API.get(
                    url: "https://httpbin.org/get",
                    complition: { result in
                        switch result {
                        case .success(let json):
                            print("\(json)")
                        case .failure(let error):
                            print("\(error.localizedDescription)")
                        }
                    })
            }) {
                Text("RestAPI GET Test")
            }
            Button(action: {
                API.post(
                    url: "https://httpbin.org/post",
                    data: ["hello":"world"],
                    complition: { result in
                        switch result {
                        case .success(let json):
                            print("Hello \(json["json"]["hello"].stringValue)!")
                        case .failure(let error):
                            print("\(error.localizedDescription)")
                        }
                    })
            }) {
                Text("RestAPI POST Test")
            }
            FavoriteButton(isSet: $isExpanded)
            Spacer()
            CustomDisclosureGroup(isExpanded: $isExpanded) {
                isExpanded.toggle()
            } prompt: {
                HStack(spacing: 0) {
                    Text("How to open an account in your application?")
                    Spacer()
                    Text(">")
                        .fontWeight(.bold)
                        .rotationEffect(isExpanded ? Angle(degrees: 90) : .zero)
                }
                .padding(.horizontal, 20)
            } expandedView: {
                Text("you can open an account by choosing between gmail or ICloud when opening the application")
                    .font(.system(size: 16, weight: .semibold, design: .monospaced))
            }
        }
        .padding()
    }
}

struct DCX001_Previews: PreviewProvider {
    static var previews: some View {
        DCX001(isExpanded: true)
            .environmentObject(ViewModel())
    }
}
