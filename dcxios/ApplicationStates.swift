import Foundation
import Combine
import SwiftyJSON

public enum Category: String, Codable, Hashable {
    case chicken = "CK"
    case pizza = "PZ"
    case bunsik = "SF"
    case caffee = "CF"
}

public enum SortOption: String, Codable, Hashable {
    case basic = "id"
    case point = "point"
    case review = "review"
}

final class ApplicationStates: ObservableObject {
    static public let filename = "data.json"
    
    static public let singleton = ApplicationStates()
    
    @Published var allShops: [Shop] = []
    @Published var dirty: Bool = false
    @Published var nameFilter: String = ""
    @Published var adFilter: Bool = false
    @Published var categoryFilter: Category? = nil
    @Published var sortOption: SortOption = .basic {
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
        let filename = ApplicationStates.filename
        
        if FileUtils.ifExists(filename: filename) {
            print("file exists.")
            loadShops()
        } else {
            print("file not exists.")
            self.allShops = load(filename)
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
    
    func loadShops() {
        let filename = ApplicationStates.filename
        do {
            let data = try FileUtils.loadData(filename: filename)
            let json = JSON(data)
            self.allShops = try decode(json.rawData())
        } catch {
            fatalError("Couldn't load \(filename). \(error.localizedDescription)")
        }
    }
    
    func saveShops() {
        print("save shops")
        let filename = ApplicationStates.filename
        do {
            try FileUtils.saveData(filename: filename, data: encode(self.allShops))
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

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let json = JSON(data)
        return try decode(json["shopList"].rawData())
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

func decode<T: Decodable>(_ data: Data) throws -> T {
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    }
}

func encode(_ data: Encodable) throws -> Data {
    do {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        return try encoder.encode(data)
    }
}
