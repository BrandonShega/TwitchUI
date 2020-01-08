import Foundation

enum StreamType: String, Codable {
    case none = ""
    case live
}

struct Stream {
    let id: String
    let userId: String
    let userName: String
    let gameId: String
    let type: StreamType
    let title: String
    let viewerCount: Int
    let startedAt: String
    let language: String
    let thumbnailUrl: String
    let tagIds: [String]
}

extension Stream: Codable {
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case userName = "user_name"
        case gameId = "game_id"
        case type
        case title
        case viewerCount = "viewer_count"
        case startedAt = "started_at"
        case language
        case thumbnailUrl = "thumbnail_url"
        case tagIds = "tag_ids"
    }
}
