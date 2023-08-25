import Foundation
import Combine
import SwiftyJSON

public enum ShopFilterCategory: String, Codable, Hashable {
    case chicken = "CK"
    case pizza = "PZ"
    case bunsik = "SF"
    case caffee = "CF"
}

public enum ShopSortOption: String, Codable, Hashable {
    case basic = "id"
    case point = "point"
    case review = "review"
}

final class ExampleShopStates: ObservableObject {
    static public let singleton = ExampleShopStates()
    static public let filename = "data.json"
    
    @Published var allShops: [Shop] = []
    @Published var dirty: Bool = false
    @Published var nameFilter: String = ""
    @Published var adFilter: Bool = false
    @Published var categoryFilter: ShopFilterCategory? = nil
    @Published var sortOption: ShopSortOption = .basic {
        didSet {
            switch sortOption {
                case .basic:
                    allShops.sort(by: {$0.id < $1.id})
                case .point:
                    allShops.sort(by: {$0.point < $1.point})
                case .review:
                    allShops.sort(by: {$0.review < $1.review})
            }
        }
    }
    
    var filteredShops: [Shop] {
        return self.allShops.filter { shop in
            var result: Bool = true
            if self.adFilter {
                print("filter ad.")
                result = result && (shop.adFlag == "Y")
            }
            if let filter = self.categoryFilter {
                print("filter category.")
                result = result && (shop.category == filter)
            }
            if self.nameFilter.utf8.count > 1 {
                print("filter name.")
                result = result && (shop.name.localizedStandardContains(self.nameFilter))
            }
            return result
        }
    }
    
    public init() {
        let filename = ExampleShopStates.filename
        
        if FileUtils.exists(filename) {
            print("file exists.")
            loadShops()
        } else {
            print("file not exists.")
            loadShopsFromBundle()
            print("save file")
            saveShops()
        }
    }

    var categories: [String: [Shop]] {
        Dictionary(
            grouping: allShops,
            by: { $0.category.rawValue }
        )
    }
    
    func loadShopsFromBundle() {
        print("load shops")
        let filename = ExampleShopStates.filename
        do {
            self.allShops = try Data.loadBundle(filename).decode()
        } catch {
            fatalError("Couldn't load \(filename). \(error.localizedDescription)")
        }
    }
    
    func loadShops() {
        print("load shops")
        let filename = ExampleShopStates.filename
        do {
            self.allShops = try Data.loadDocument(filename).decode()
        } catch {
            fatalError("Couldn't load \(filename). \(error.localizedDescription)")
        }
    }
    
    func saveShops() {
        print("save shops")
        let filename = ExampleShopStates.filename
        do {
            try self.allShops.asData().saveData(filename: ExampleShopStates.filename)
        } catch {
            fatalError("Couldn't save \(filename). \(error.localizedDescription)")
        }
    }
    
    func deleteShop(at index: IndexSet) {
        let selectedIndex = index.first!
        let selectedShop = filteredShops[selectedIndex]
        let targetIndex = allShops.firstIndex(of: selectedShop)
        allShops.remove(at: targetIndex!)
        saveShops()
        // you can use multiple selected items with this
        // offsets.sorted(by: >).forEach { i in
        //     //...
        // }
    }
}



