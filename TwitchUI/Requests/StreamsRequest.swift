import Foundation
import Keys

struct StreamsRequest: APIRequest {
    let follows: [Follow]
    let path = "/streams"
    
    let requiresAuthentication = false
    
    func networkRequest(baseURL: URL) throws -> NetworkRequest {
        let userIds = follows.map { $0.toId }.joined(separator: "&user_id=")
        return NetworkRequest(
            method: .GET,
            url: baseURL.appendingPathComponent(path),
            headers: ["Client-ID": TwitchUIKeys().twitchAPIClientID],
            body: nil,
            query: ["user_id": userIds]
        )
    }
    
    func handle(response: NetworkResponse) throws -> [Stream] {
        guard let data = response.data else { throw NetworkError.invalidResponse }
        print(try! JSONSerialization.jsonObject(with: data, options: []))
        let apiResponse = try JSONDecoder().decode(APIResponse<[Stream]>.self, from: data)
        return apiResponse.data
    }
}
