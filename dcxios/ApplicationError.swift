import Foundation

enum ApplicationError: LocalizedError {
    case wrap(Error)
    case withMessage(String)
    
    public var errorDescription: String? {
        switch self {
        case .wrap(let error):
            return error.localizedDescription
        case .withMessage(let message):
            return message
        }
    }
    
    public var failureReason: String? {
        switch self {
        case .wrap(let origin):
            return (origin as? LocalizedError)?.failureReason
        case .withMessage(_):
            return nil
        }
    }
}
