import SwiftUI

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
        .padding(1)
        .font(.system(size: 15))
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
        .padding(10)
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

struct ShopDetailView: View {
    @EnvironmentObject var model: dcxiosStates
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

struct View1: View {
    @EnvironmentObject var model: dcxiosStates
    
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
                    NavigationLink(destination: ShopDetailView(item: shop)) {
                        ShopView(shop: shop)
                    }
                }
                
                HStack(alignment: .center) {
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
                        Text("FETCH SHOP LIST")
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle)
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
        View1()
            .environmentObject(dcxiosStates.singleton)
    }
}
