// Data.swift

import Foundation

extension Data {
    static public func loadBundle(_ filename: String) throws -> Data {
        guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
            else {
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        return try Data(contentsOf: file)
    }
    
    static public func loadDocument(_ filename: String) throws -> Data {
        guard let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ApplicationError.withMessage("unable to load file: \(filename)")
        }
        let filepath = dirpath.appendingPathComponent(filename)
        return try Data(contentsOf: filepath.asURL())
    }
    
    func decode<T: Decodable>() throws -> T {
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: self)
        }
    }
    
    func saveData(filename: String) throws {
        guard let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ApplicationError.withMessage("unable to save file: \(filename)")
        }
        let filepath = dirpath.appendingPathComponent(filename)
        try self.write(to: filepath)
    }
}
