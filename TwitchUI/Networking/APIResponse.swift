import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let data: T
}
