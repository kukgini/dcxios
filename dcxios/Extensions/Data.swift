// Data.swift

import Foundation

extension Data {
    static public func loadData(filename: String) throws -> Data {
        guard let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ApplicationError.withMessage("unable to load file: \(filename)")
        }
        let filepath = dirpath.appendingPathComponent(filename)
        return try Data(contentsOf: filepath.asURL())
    }
    
    func saveData(filename: String) throws {
        guard let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ApplicationError.withMessage("unable to save file: \(filename)")
        }
        let filepath = dirpath.appendingPathComponent(filename)
        try self.write(to: filepath)
    }
}
