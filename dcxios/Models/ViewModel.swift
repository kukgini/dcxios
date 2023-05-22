// ModelData.swift

import Foundation
import Combine
import SwiftyJSON

public enum DCXView {
    case dcx001
    case dcx002
}

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
    @Published var greeting = "Hello from Environment!"
    @Published var currentView: DCXView = .dcx001
    @Published var shopList: [Shop]
    @Published var shop: Shop?
    @Published var filter: Category? = nil
    @Published var sortOption: SortOption = .basic {
        willSet(newOption) {
            switch newOption {
                case .basic:
                    shopList.sort(by: {$0.id < $1.id})
                case .point:
                    shopList.sort(by: {$0.point < $1.point})
                case .review:
                    shopList.sort(by: {$0.review < $1.review})
            }
        }
    }
    
    public init() {
        self.shopList = load("mockdata.json")
    }
    
    var adFlag: [Shop] {
        shopList.filter { $0.adFlag == "Y" }
    }

    var categories: [String: [Shop]] {
        Dictionary(
            grouping: shopList,
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
