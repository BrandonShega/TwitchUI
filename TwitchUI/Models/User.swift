import Foundation
import UIKit

enum UserType: String, Codable {
    case staff
    case admin
    case globalMod = "global_mod"
    case none = ""
}

enum UserBroadcasterType: String, Codable {
    case partner
    case affiliate
    case none = ""
}

struct User {
    let broadcasterType: UserBroadcasterType
    let description: String
    let displayName: String
    let id: String
    let login: String
    let offlineImageUrl: String
    let profileImageUrl: String
    let type: UserType
    let viewCount: Int
}

extension User: Codable {
    enum CodingKeys: String, CodingKey {
        case broadcasterType = "broadcaster_type"
        case description
        case displayName = "display_name"
        case id
        case login
        case offlineImageUrl = "offline_image_url"
        case profileImageUrl = "profile_image_url"
        case type
        case viewCount = "view_count"
    }
}

extension User {
    static var defaultUser: User {
        return User(broadcasterType: .none,
                    description: "",
                    displayName: "",
                    id: "",
                    login: "",
                    offlineImageUrl: "",
                    profileImageUrl: "",
                    type: .none,
                    viewCount: 0
        )
    }
    
    static var testUser: User {
        return User(broadcasterType: .none,
                    description: "Test Description",
                    displayName: "Test User",
                    id: "",
                    login: "testuser",
                    offlineImageUrl: "",
                    profileImageUrl: "",
                    type: .none,
                    viewCount: 99
        )
    }
}
