import Foundation

struct UserResponse: Decodable {
    
    let code: Int
    let meta: Meta?
    let data: User

}

struct User: Decodable {
    let id: Int?
    let name: String?
    let email: String?
    let gender: String?
    let status: String?
    let createdAt: Date?
    let updatedAt: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case email
        case gender
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Meta: Decodable {
    
}
