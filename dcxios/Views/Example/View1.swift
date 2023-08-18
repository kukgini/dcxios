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
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
        // if ios 1.5
        // .buttonStyle(BorderlessButtonStyle())
        // .padding(10)
        // .overlay(
        //     RoundedRectangle(cornerRadius: 10)
        //         .stroke(lineWidth: 1)
        // )
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
        .textFieldStyle(.roundedBorder)
        // if ios < 15
        // .padding(10)
        // .background(
        //     RoundedRectangle(cornerRadius: 10)
        //         .stroke(lineWidth: 1)
        // )
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
        .buttonStyle(.bordered)
        .buttonBorderShape(.roundedRectangle)
    }
}

struct ShopView: View {
    var shop: Shop
    
    var body: some View {
        HStack {
            VStack (alignment: .leading){
                HStack {
                    Text(shop.name)
                    if shop.adFlag == "Y" {
                        Image(systemName: "star.fill")
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

struct View1: View {
    @EnvironmentObject var model: dcxiosStates
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
                    NavigationLink(destination: View2(item: shop)) {
                        ShopView(shop: shop)
                    }
                }
                
                ForEach(1..<5) { index in
                    if index % 2 != 0 {
                        ListItemView(alignment: .left, title: "Title \(index)", description: "BlaBla... \(index)")
                    } else {
                        ListItemView(alignment: .right, title: "Title \(index)", description: "BlaBla... \(index)")
                    }
                }
                
                HStack {
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
                    Text("|")
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
                    Text("|")
                    Button(action: {
                        RestClient.get(
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
            .navigationBarTitle("View1")
            .navigationBarItems(
                leading: Text("A"),
                trailing: Text("B"))
        }
    }
}

struct View1_Previews: PreviewProvider {
    static var previews: some View {
        View1(isExpanded: true)
            .environmentObject(dcxiosStates.singleton)
    }
}
