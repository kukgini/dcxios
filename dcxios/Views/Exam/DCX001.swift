// DCX001.swift

import SwiftUI

struct DCX001: View {
    @EnvironmentObject var model: ModelData
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text(model.greeting)
            Button(action: {
                RestAPI.post(
                    url: "https://httpbin.org/get",
                    complition: { response in
                        switch response {
                        case .success(let json):
                            print("\(json)")
                        case .failure(let error):
                            print("\(error.localizedDescription)")
                        }
                    })
            }) {
                Text("RestAPI Test")
            }
        }
        .padding()
    }
}

struct DCX001_Previews: PreviewProvider {
    static var previews: some View {
        DCX001()
            .environmentObject(ModelData())
    }
}
