
import Foundation

public struct Shop: Codable, Identifiable {
    public var id: Int
    public var category: Category
    public var name: String
    public var point: Double
    public var review: Int
    public var adFlag: String
    public var imageFile: String
}
