import Foundation
import Keys

struct FollowsRequest: APIRequest {
    let user: User
    let path = "/users/follows"
    
    let requiresAuthentication = false
    
    func networkRequest(baseURL: URL) throws -> NetworkRequest {
        return NetworkRequest(
            method: .GET,
            url: baseURL.appendingPathComponent(path),
            headers: ["Client-ID": TwitchUIKeys().twitchAPIClientID],
            body: nil,
            query: ["from_id": user.id]
        )
    }
    
    func handle(response: NetworkResponse) throws -> [Follow] {
        guard let data = response.data else { throw NetworkError.invalidResponse }
        let apiResponse = try JSONDecoder().decode(APIResponse<[Follow]>.self, from: data)
        return apiResponse.data
    }
}
