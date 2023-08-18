// ExampleRestClientView.swift

import SwiftUI

struct ExampleRestClientView: View {
    @EnvironmentObject var model: dcxiosStates
    
    var body: some View {
        VStack(alignment: .center) {
            Button(action: {
                RestClient.get(
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
                Text("GET")
            }
            Button(action: {
                RestClient.post(
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
                Text("POST")
            }
        }
//        Spacer()
    }
}

struct ExampleRestClientView_Previews: PreviewProvider {
    static var previews: some View {
        ExampleRestClientView()
    }
}
