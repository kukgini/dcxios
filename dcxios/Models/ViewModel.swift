// ModelData.swift

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

final class ViewModel: ObservableObject {
    public static let singleton = ViewModel(file: "mockdata.json")
    
    @Published var shopList: [Shop]
    @Published var nameFilter: String = ""
    @Published var adFilter: Bool = false
    @Published var categoryFilter: Category? = nil
    @Published var sortOption: SortOption = .basic {
        didSet {
            switch sortOption {
                case .basic:
                    shopList.sort(by: {$0.id < $1.id})
                case .point:
                    shopList.sort(by: {$0.point < $1.point})
                case .review:
                    shopList.sort(by: {$0.review < $1.review})
            }
        }
    }
    
    public init(file: String) {
        self.shopList = load(file)
    }

    var categories: [String: [Shop]] {
        Dictionary(
            grouping: shopList,
            by: { $0.category.rawValue }
        )
    }
    
    var filteredShops: [Shop] {
        self.shopList.filter { shop in
            var result: Bool = true
            if self.adFilter {
                result = result && (shop.adFlag == "Y")
            }
            if let filter = self.categoryFilter {
                result = result && (shop.category == filter)
            }
            if self.nameFilter.count > 1 {
                result = result && (shop.name.contains(self.nameFilter))
            }
            return result
        }
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
