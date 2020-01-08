import Foundation

struct Pagination: Decodable {
    let cursor: String
}

struct APIResponse<T: Decodable>: Decodable {
    let data: T
    let total: Int?
    let pagination: Pagination?
}
