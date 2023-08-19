import SwiftUI

struct CategoryFilterButton: View {
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

struct SortButton: View {
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
                        FavoriteButton(isSet: $model.adFilter)
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
                        SearchBar(text: self.model.nameFilter, complition: { name in
                            print("searching... \(model.nameFilter)")
                            self.model.nameFilter = name
                            
                        })
                    }
                }
                ForEach(model.filteredShops) { shop in
                    NavigationLink(destination: ShopDetailView(item: shop)) {
                        ShopView(shop: shop)
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
                            model.allShops = try decode(json["shopList"].rawData())
                            model.dirty = true
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

struct View1_Previews: PreviewProvider {
    static var previews: some View {
        View1()
            .environmentObject(dcxiosStates.singleton)
    }
}
