import Foundation
import Combine

enum NetworkError: LocalizedError {
    case invalidResponse
    case invalidURL
    case couldNotBuildRequest
    case malformedUrl
    case authenticationRequired
    case networkError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Received an unexpected resposne"
        case .invalidURL:
            return "Invalid URL"
        case .couldNotBuildRequest:
            return "Could not build request"
        case .malformedUrl:
            return "Malformed URL"
        case .authenticationRequired:
            return "Authentication required"
        case .networkError(let reason):
            return reason
        }
    }
}

protocol Network {
    func perform(request: NetworkRequest) -> AnyPublisher<NetworkResponse, NetworkError>
}
