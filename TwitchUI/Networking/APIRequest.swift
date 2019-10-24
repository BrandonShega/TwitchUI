import Foundation

protocol APIRequest {
    associatedtype Response
    
    var path: String { get }
    var query: [String: String]? { get }
    var body: Data? { get }
    var headers: [String: LosslessStringConvertible] { get }
    
    var requiresAuthentication: Bool { get }
    
    func networkRequest(baseURL: URL) throws -> NetworkRequest
    
    func handle(response: NetworkResponse) throws -> Response
}

extension APIRequest {
    var requiresAuthentication: Bool { return true }
    var query: [String: String]? { return nil }
    var body: Data? { return nil }
    var headers: [String: LosslessStringConvertible] { return [:] }
    
    func url(baseUrl: URL) throws -> URL {
        guard var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false)
            else { throw NetworkError.malformedUrl }
        components.path = components.path.appending(path)
        components.queryItems = query?.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = components.url else { throw NetworkError.malformedUrl }
        return url
    }
}

