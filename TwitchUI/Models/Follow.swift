import Foundation

struct Follow {
    let fromId: String
    let fromName: String
    let toId: String
    let toName: String
    let followedAt: String
}

extension Follow: Codable {
    enum CodingKeys: String, CodingKey {
        case fromId = "from_id"
        case fromName = "from_name"
        case toId = "to_id"
        case toName = "to_name"
        case followedAt = "followed_at"
    }
}
