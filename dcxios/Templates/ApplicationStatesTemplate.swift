import Foundation
import Combine
import SwiftyJSON

public enum CategoryFilterTemplate: String, Codable, Hashable {
    case category1 = "category1"
    case category2 = "category2"
}

public enum SortOptionTemplate: String, Codable, Hashable {
    case option1 = "option1"
    case option2 = "option2"
}

final class ApplicationStatesTemplate: ObservableObject {
    static public let singleton = ApplicationStates()
    
    @Published var allItems: [JSON] = []
    @Published var categoryFilter: CategoryFilterTemplate? = nil
    @Published var sortOption: SortOptionTemplate = .option1 {
        didSet {
            switch sortOption {
                case .option1:
                    allItems.sort(by: { $0.stringValue < $1.stringValue })
                case .option2:
                    allItems.sort(by: { $0.stringValue < $1.stringValue })
            }
        }
    }
    var filteredItems: [JSON] {
        return self.allItems.filter { item in
            return true
        }
    }
}
