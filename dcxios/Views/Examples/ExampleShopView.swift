import SwiftUI

struct ShopCategoryFilterButton: View {
    var label: String
    @Binding var filter: Category?
    var category: Category?
    
    var body: some View {
        Button(action: {
            print("filter category: \(category?.rawValue ?? "")")
            filter = category
        }) {
            Text(label)
        }
        // [Important] buttonStyle needed for SwiftUI bug:
        // https://stackoverflow.com/questions/63087817/strange-buttons-behaviour-in-a-list-swiftui
         .buttonStyle(BorderlessButtonStyle())
//         .padding(10)
//         .overlay(
//             RoundedRectangle(cornerRadius: 10)
//                 .stroke(lineWidth: 0)
//                 .foregroundColor(Color.blue)
//         )
//        .font(.system(size: 13))
    }
}

struct ShopSortButton: View {
    var label: String
    @Binding var option: SortOption
    var key: SortOption
    
    var body: some View {
        Button(action: {
            print("sort option: \(key.rawValue)")
            option = key
        }) {
            Text(label)
        }
        // [Important] buttonStyle needed for SwiftUI bug:
        // https://stackoverflow.com/questions/63087817/strange-buttons-behaviour-in-a-list-swiftui
        .buttonStyle(BorderlessButtonStyle())
//        .padding(10)
//        .overlay(
//            RoundedRectangle(cornerRadius: 10)
//                .stroke(lineWidth: 0)
//                .foregroundColor(Color.blue)
//        )
//        .font(.system(size: 13))
    }
}

struct ShopItemView: View {
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

struct ExampleShopView: View {
    @EnvironmentObject var appStates: ApplicationStates
    
    var body: some View {
        NavigationView {
            List {
                VStack(alignment: .center) {
                    HStack {
                        SearchBar(complition: { newNameFilter in
                            print("searching... \(newNameFilter)")
                            self.appStates.nameFilter = newNameFilter
                        })
                    }
                    HStack(alignment: .center) {
                        FavoriteButton(isSet: $appStates.adFilter)
                        ShopCategoryFilterButton(label: "전체", filter: $appStates.categoryFilter, category: nil)
                        ShopCategoryFilterButton(label: "치킨", filter: $appStates.categoryFilter, category: .chicken)
                        ShopCategoryFilterButton(label: "피자", filter: $appStates.categoryFilter, category: .pizza)
                        ShopCategoryFilterButton(label: "분식", filter: $appStates.categoryFilter, category: .bunsik)
                        ShopCategoryFilterButton(label: "카페", filter: $appStates.categoryFilter, category: .caffee)
                        
                    }
                    HStack(alignment: .center) {
                        ShopSortButton(label: "기본 정렬순", option: $appStates.sortOption, key: .basic)
                        ShopSortButton(label: "별점 높은순", option: $appStates.sortOption, key: .point)
                        ShopSortButton(label: "리뷰 많은순", option: $appStates.sortOption, key: .review)
                    }
                }
                ForEach(appStates.filteredShops) { shop in
                    NavigationLink(destination: ShopDetailView(item: shop)) {
                        ShopItemView(shop: shop)
                    }
                }
            }
            .navigationBarTitle("View1")
            .navigationBarItems(
                leading: Text("A"),
                trailing: fetchButton())
        }
    }
    
    func fetchButton() -> some View {
        Button(action: {
            RestClient.get(
                url: "http://localhost:3000/dcx/1/shopList",
                complition: { result in
                    switch result {
                    case .success(let json):
                        do {
                            print(json["shopList"])
                            appStates.allShops = try decode(json["shopList"].rawData())
                            appStates.dirty = true
                        } catch {
                            print("GET shopList failed. \(error)")
                        }
                    case .failure(let error):
                        print("\(error.localizedDescription)")
                    }
                })
        }) {
            Text("Update")
        }
    }
}
