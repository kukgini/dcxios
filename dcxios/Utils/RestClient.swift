import Foundation
import Alamofire
import SwiftyJSON

public struct RestClient {
    
    static let defaultApiHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ] as HTTPHeaders
    
    static func get(url: String, data: [String:Any]? = nil, complition: @escaping(Result<JSON,Error>) -> Void) {
        let encoding = JSONEncoding.default
        let headers = defaultApiHeaders
        AF.request(url, method: .get, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success(let body):
                    complition(.success(JSON(body ?? "{}")))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
    
    static func post(url: String, data: [String:Any]? = nil, complition: @escaping(Result<JSON,Error>) -> Void) {
        let encoding = JSONEncoding.default
        let headers = defaultApiHeaders
        AF.request(url, method: .post, parameters: data, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .response { response in
                switch response.result {
                case .success(let body):
                    complition(.success(JSON(body ?? "{}")))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
}
