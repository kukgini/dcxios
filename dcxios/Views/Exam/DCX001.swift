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
