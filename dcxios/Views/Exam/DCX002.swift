// DCX002.swift

import SwiftUI

struct DCX002: View {
    @EnvironmentObject var model: ModelData
    
    var body: some View {
        Text(model.greeting)
    }
}

struct DCX002_Previews: PreviewProvider {
    static var previews: some View {
        DCX002()
            .environmentObject(ModelData())
    }
}
