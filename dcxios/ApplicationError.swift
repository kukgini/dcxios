// ApplicationError.swift

import Foundation

enum ApplicationError: LocalizedError {
    case wrap(Error)
    case custom(String)
    
    public var errorDescription: String? {
        switch self {
        case .wrap(let error):
            return error.localizedDescription
        case .custom(let message):
            return message
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .wrap(let origin):
            return (origin as? LocalizedError)?.failureReason
        case .custom(_):
            return nil
        }
    }
}
