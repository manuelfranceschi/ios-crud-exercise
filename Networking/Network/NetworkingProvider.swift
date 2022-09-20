import Foundation
import Alamofire
import Kingfisher

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    private let kBaseUrl = "https://gorest.co.in/public-api/"
    private let kStatusOk = 200...299
    private let kToken = "98561e108c5088a6941eafb1e426b37d6f3e192b7252c81a2f3ec41401dccc3f"
    
    
    func getUser(id: Int, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = "\(kBaseUrl)users/\(id)"
        
        AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
            
            if let user = response.value?.data {
                success(user)
            } else {
                failure(response.error)
            }
        }
    }
    
    func addUser(user: NewUser, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = "\(kBaseUrl)users"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
            
            if let user = response.value?.data, user.id != nil {
                success(user)
            } else {
                failure(response.error)
            }
        }
    }
    
    func updateUser(id: Int, user: NewUser, success: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = "\(kBaseUrl)users/\(id)"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: headers).validate(statusCode: kStatusOk).responseDecodable (of: UserResponse.self, decoder: DateDecoder()) { response in
            
            if let user = response.value?.data, user.id != nil {
                success(user)
            } else {
                failure(response.error)
            }
        }
    }
    
    func deleteUser(id: Int, success: @escaping () -> (), failure: @escaping (_ error: Error?) -> ()) {
        
        let url = "\(kBaseUrl)users/\(id)"
        
        let headers: HTTPHeaders = [.authorization(bearerToken: kToken)]
        
        AF.request(url, method: .delete, headers: headers).validate(statusCode: kStatusOk).response { response in
            
            if let error = response.error {
                failure(error)
            } else {
                success()
            }
        }
    }
    
    
}

