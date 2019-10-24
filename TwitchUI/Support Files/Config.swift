import Foundation

struct Config {
    static var baseUrl: URL {
        return URL(string: "https://api.twitch.tv/helix")!
    }
}
