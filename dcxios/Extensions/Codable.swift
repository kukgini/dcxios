// Codable.swift

import Foundation

extension Encodable {
    func asData() throws -> Data {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            return try encoder.encode(self)
        }
    }
}
