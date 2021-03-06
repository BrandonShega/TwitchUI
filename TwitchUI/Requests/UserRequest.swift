import Foundation

struct UserRequest: APIRequest {
    let path = "/users"
    
    let requiresAuthentication: Bool = true
    
    func networkRequest(baseURL: URL) throws -> NetworkRequest {
        return NetworkRequest(method: .GET,
                              url: baseURL.appendingPathComponent(path),
                              headers: [:],
                              body: nil
        )
    }
    
    func handle(response: NetworkResponse) throws -> User? {
        guard let data = response.data else { throw NetworkError.invalidResponse }
        let apiResponse = try JSONDecoder().decode(APIResponse<[User]>.self, from: data)
        return apiResponse.data.first
    }
}
