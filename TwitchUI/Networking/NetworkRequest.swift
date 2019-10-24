import Foundation

struct NetworkRequest {
    var method: Method
    var url: URL
    var headers: [String: LosslessStringConvertible]
    var body: Data?
    
    func buildRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
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
