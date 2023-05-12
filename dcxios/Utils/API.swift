import Foundation
import Alamofire
import SwiftyJSON

public struct API {
    
    static let defaultApiHeaders = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ] as HTTPHeaders
    
    static func get(url: String, data: [String:Any]? = nil, complition: @escaping(Result<[String:Any],Error>) -> Void) {
        let encoding = JSONEncoding.default
        let headers = defaultApiHeaders
        AF.request(url, method: .get, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let body):
                    complition(.success(body as! [String:Any]))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
    
    static func post(url: String, data: [String:Any]? = nil, complition: @escaping(Result<[String:Any],Error>) -> Void) {
        let encoding = JSONEncoding.default
        let headers = defaultApiHeaders
        AF.request(url, method: .post, parameters: data, encoding: encoding, headers: headers)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success(let body):
                    complition(.success(body as! [String:Any]))
                case .failure(let error):
                    complition(.failure(error))
                }
            }
    }
}
