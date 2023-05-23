// DCX002.swift

import SwiftUI

struct DCX002: View {
    @EnvironmentObject var model: ViewModel
    
    var body: some View {
        NavigationView {
            VStack (alignment: .center) {
                if let shop = model.shop {
                    Image(systemName: "star")
                        .imageScale(.large)
                        .frame(width: 100.0, height: 100.0, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 5)
                        )
                    Text(shop.name)
                    Text(shop.category.rawValue)
                } else {
                    Text ("no shop selected")
                }
            }
            .padding()
            .navigationBarTitle("Sub View")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(
                leading: ViewChangeButton(label: "<", view: .dcx001),
                trailing: Text("B"))
        }
    }
}

struct DCX002_Previews: PreviewProvider {
    static var previews: some View {
        DCX002()
            .environmentObject(ViewModel())
    }
}
