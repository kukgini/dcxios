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

final class dcxiosStates: ObservableObject {
    public static let singleton = dcxiosStates(file: "mockdata.json")
    
    @Published var allShops: [Shop]
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
    
    public init(file: String) {
        self.allShops = load(file)
    }

    var categories: [String: [Shop]] {
        Dictionary(
            grouping: allShops,
            by: { $0.category.rawValue }
        )
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
