import Foundation

struct NetworkRequest {
    var method: Method
    var url: URL
    var headers: [String: LosslessStringConvertible]
    var body: Data?
    var query: [String: String]?
    
    func buildRequest() throws -> URLRequest {
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            else { throw NetworkError.malformedUrl }
        components.queryItems = query?.map { URLQueryItem(name: $0.key, value: $0.value) }
        guard let queryUrl = components.url else { throw NetworkError.malformedUrl }
        
        var request = URLRequest(url: queryUrl)
        request.httpMethod = method.rawValue
        
        for (key, value) in headers {
            request.addValue(value.description, forHTTPHeaderField: key)
        }
        
        request.httpBody = body
        return request
    }
}

extension NetworkRequest {
    enum Method: String {
        case GET, PUT, POST, PATCH, DELETE
    }
}
