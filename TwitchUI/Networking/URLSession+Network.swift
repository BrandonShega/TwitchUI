import Foundation
import Combine

extension URLSession: Network {
    func perform(request: NetworkRequest) -> AnyPublisher<NetworkResponse, NetworkError> {
        do {
            let urlRequest = try request.buildRequest()
            
            return dataTaskPublisher(for: urlRequest)
                .tryMap { data, response in
                    guard let httpResponse = response as? HTTPURLResponse,
                        200..<300 ~= httpResponse.statusCode
                        else { throw NetworkError.invalidResponse }
                    let networkResponse = NetworkResponse(response: httpResponse, data: data)
                    return networkResponse
            }
            .mapError { error in
                return (error as? NetworkError) ?? .networkError(reason: error.localizedDescription)
            }
            .eraseToAnyPublisher()
            
        } catch {
            return Fail(error: .couldNotBuildRequest)
                .eraseToAnyPublisher()
        }
    }
}
