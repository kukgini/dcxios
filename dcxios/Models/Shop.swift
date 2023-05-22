
import Foundation

public struct Shop: Codable, Identifiable {
    public var id: Int
    public var category: Category
    public var name: String
    public var point: Double
    public var review: Int
    public var adFlag: String
    public var imageFile: String
    
    enum CodingKeys : String, CodingKey{
            case id
            case category
            case name
            case point
            case review
            case adFlag
            case imageFile
            //case birthday = "birth_date"
        }
}
