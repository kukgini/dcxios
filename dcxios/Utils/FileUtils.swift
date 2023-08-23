import Foundation

public struct FileUtils {
    static func saveData(filename: String, data: Data) throws {
        guard let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ApplicationError.withMessage("unable to save file: \(filename)")
        }
        let filepath = dirpath.appendingPathComponent(filename)
        try data.write(to: filepath)
        print("file save \(filepath.absoluteString)")
    }
    
    static func loadData(filename: String) throws -> Data {
        guard let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            throw ApplicationError.withMessage("unable to load file: \(filename)")
        }
        let filepath = dirpath.appendingPathComponent(filename)
        print("file load \(filepath.absoluteString)")
        return try Data(contentsOf: filepath.asURL())
    }
    
    static func ifExists(filename: String) -> Bool {
        guard let dirpath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return false
        }
        let filepath = dirpath.appendingPathComponent(filename)
        let result = FileManager.default.fileExists(atPath: filepath.path)
        print("check file exists \(filepath.absoluteString) --> \(result)")
        return result
    }
}
