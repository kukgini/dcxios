// DCX002.swift

import SwiftUI

struct View2: View {
    @EnvironmentObject var model: ViewModel
    let item: Shop?
    
    var body: some View {
        if let shop = self.item {
            NavigationView {
                VStack (alignment: .center) {
                    Image(systemName: "star")
                        .imageScale(.large)
                        .frame(width: 100.0, height: 100.0, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(lineWidth: 5)
                        )
                    Text(shop.name)
                    Text(shop.category.rawValue)

                }
                .padding()
                .navigationBarTitle(shop.name)
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(
                    leading: Text("A"),
                    trailing: Text("B"))
            }
        } else {
            NavigationView {
                VStack (alignment: .center) {
                    Text ("no shop selected")
                }
            }
        }
    }
}

struct View2_Previews: PreviewProvider {
    static var previews: some View {
        View2(item: ViewModel.singleton.shopList.first)
            .environmentObject(ViewModel.singleton)
        View2(item: nil)
            .environmentObject(ViewModel.singleton)
    }
}
