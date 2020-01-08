import Foundation
import Keys

protocol APIRequest {
    associatedtype Response
    
    var requiresAuthentication: Bool { get }
    
    func networkRequest(baseURL: URL) throws -> NetworkRequest
    
    func handle(response: NetworkResponse) throws -> Response
}

extension APIRequest {
    var requiresAuthentication: Bool { return true }
}

