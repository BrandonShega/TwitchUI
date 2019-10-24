import Foundation
import Combine

final class API {
    private let network: Network
    private let baseURL: URL
    
    init(network: Network, baseURL: URL) {
        self.network = network
        self.baseURL = baseURL
    }
    
    func execute<T: APIRequest>(request: T) -> AnyPublisher<T.Response, NetworkError> {
        do {
            let networkRequest = try buildNetworkRequest(from: request)
            
            return self.network.perform(request: networkRequest)
                .tryMap { try request.handle(response: $0) }
                .mapError { error in
                    return (error as? NetworkError) ?? NetworkError.networkError(reason: error.localizedDescription)
            }
            .eraseToAnyPublisher()
        } catch {
            return Fail(error: .couldNotBuildRequest)
                .eraseToAnyPublisher()
        }
    }
    
    private func buildNetworkRequest<T: APIRequest>(from request: T) throws -> NetworkRequest {
        var networkRequest = try request.networkRequest(baseURL: baseURL)
        
        guard request.requiresAuthentication else { return networkRequest }
        
        guard let token = TokenStore.token else { throw NetworkError.authenticationRequired }
        
        var headers = networkRequest.headers
        headers["Authorization"] = "Bearer \(token)"
        
        networkRequest.headers = headers
        return networkRequest
    }
}
