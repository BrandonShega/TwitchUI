import Foundation
import Combine
import UIKit

enum ImageRequestError: LocalizedError {
    case invalidUrl
    case imageRequestError(reason: String)
    
    var localizedDescription: String {
        switch self {
        case .invalidUrl:
            return "Invalid URL"
        case .imageRequestError(let reason):
            return reason
        }
    }
}

struct ImageRequest {
    let url: String
}

extension ImageRequest {
    func download() -> AnyPublisher<UIImage, ImageRequestError> {
        guard let url = URL(string: url) else { return Fail(error: .invalidUrl).eraseToAnyPublisher() }
        return URLSession.shared.dataTaskPublisher(for: url)
        .map { UIImage(data: $0.data) ?? UIImage() }
        .mapError{ error in
            return .imageRequestError(reason: error.localizedDescription)
        }
        .eraseToAnyPublisher()
    }
}
