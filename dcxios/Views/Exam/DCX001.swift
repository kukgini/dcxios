// DCX001.swift

import SwiftUI

struct SortButton: View {
    var label: String
    @Binding var option: SortOption
    var key: SortOption
    
    var body: some View {
        Button(action: {
            option = key
        }) {
            Text(label)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
        )
    }
}

struct NameFilterField: View {
    var label: String
    @Binding var filter: String
    
    var body: some View {
        TextField(
            label,
            text: $filter
        )
        .disableAutocorrection(true)
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 1)
        )
    }
}

struct CategoryFilterButton: View {
    var label: String
    @Binding var filter: Category?
    var category: Category?
    
    var body: some View {
        Button(action: {
            filter = category
        }) {
            Text(label)
        }
        .buttonStyle(BorderlessButtonStyle())
        .padding(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.purple, lineWidth: 1)
        )
    }
}

struct ShopView: View {
    var shop: Shop
    
    var body: some View {
        HStack {
            Image(systemName: "star")
                .imageScale(.large)
            VStack (alignment: .leading){
                HStack {
                    Text(shop.name)
                    if shop.adFlag == "Y" {
                        Image(systemName: "star")
                    }
                }
                HStack {
                    Text(String(shop.point))
                    Text(String(shop.review))
                }
            }
        }
    }
}

struct DCX001: View {
    @EnvironmentObject var model: ViewModel
    @State var isExpanded: Bool
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    HStack(alignment: .center) {
                        CategoryFilterButton(label: "전체", filter: $model.categoryFilter, category: nil)
                        CategoryFilterButton(label: "치킨", filter: $model.categoryFilter, category: .chicken)
                        CategoryFilterButton(label: "피자", filter: $model.categoryFilter, category: .pizza)
                        CategoryFilterButton(label: "분식", filter: $model.categoryFilter, category: .bunsik)
                        CategoryFilterButton(label: "카페", filter: $model.categoryFilter, category: .caffee)
                    }
                    HStack(alignment: .center) {
                        SortButton(label: "기본 정렬순", option: $model.sortOption, key: .basic)
                        SortButton(label: "별점 높은순", option: $model.sortOption, key: .point)
                        SortButton(label: "리뷰 많은순", option: $model.sortOption, key: .review)
                    }
                    HStack {
                        NameFilterField(label: "Shop Name", filter: $model.nameFilter)
                        FavoriteButton(isSet: $model.adFilter)
                    }
                }
                
                ForEach(model.filteredShops) { shop in
                    Button(action: {
                        model.shop = shop
                        model.currentView = .dcx002
                    }) {
                        ShopView(shop: shop)
                    }
                }
                
                ForEach(1..<10) { index in
                    if index % 2 != 0 {
                        ListItemView(alignment: .left, title: "Title \(index)", description: "BlaBla... \(index)")
                    } else {
                        ListItemView(alignment: .right, title: "Title \(index)", description: "BlaBla... \(index)")
                    }
                }
                
                HStack {
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
                        Text("GET")
                    }
                    Text("|")
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
                        Text("POST")
                    }
                    Text("|")
                    Button(action: {
                        API.get(
                            url: "http://localhost:3000/dcx/1/shopList",
                            complition: { result in
                                switch result {
                                case .success(let json):
                                    do {
                                        print(json["shopList"])
                                        model.shopList = try decode(json["shopList"].rawData())
                                    } catch {
                                        print("GET shopList failed. \(error)")
                                    }
                                case .failure(let error):
                                    print("\(error.localizedDescription)")
                                }
                            })
                    }) {
                        Text("SHOP LIST")
                    }
                }
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
            .navigationBarTitle("DCX001")
            .navigationBarItems(
                leading: Text("A"),
                trailing: Text("B"))
        }
    }
}

struct DCX001_Previews: PreviewProvider {
    static var previews: some View {
        DCX001(isExpanded: true)
            .environmentObject(ViewModel())
    }
}
