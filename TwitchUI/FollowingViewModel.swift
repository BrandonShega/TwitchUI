import Foundation
import UIKit
import Combine

class FollowingViewModel: ObservableObject, Identifiable {
    @Published var currentUser: User
    @Published var userImage: UIImage
    @Published var follows: [Follow] = []
    
    private var cancellableSet: Set<AnyCancellable> = []
    
    init(currentUser: User = User.defaultUser, userImage: UIImage = UIImage()) {
        self.currentUser = currentUser
        self.userImage = userImage
    }
    
    func getUser() {
        let userRequest = UserRequest()
        let api = API(network: URLSession.shared, baseURL: Config.baseUrl)
        let user = api.execute(request: userRequest).share()
        user.catch { _ in Empty() }
            .compactMap { $0 }
            .receive(on: RunLoop.main)
            .assign(to: \.currentUser, on: self)
            .store(in: &cancellableSet)
        
        $currentUser.catch { _ in Empty() }
            .compactMap { $0 }
            .flatMap { user -> AnyPublisher<UIImage, ImageRequestError> in
                let profileUrl = user.profileImageUrl
                return ImageRequest(url: profileUrl).download()
                    .eraseToAnyPublisher()
        }
        .catch { _ in Empty() }
        .receive(on: RunLoop.main)
        .assign(to: \.userImage, on: self)
        .store(in: &cancellableSet)
        
        user.catch { _ in Empty() }
            .compactMap { $0 }
            .flatMap { user -> AnyPublisher<[Follow], NetworkError> in
                let followsRequest = FollowsRequest(user: user)
                return api.execute(request: followsRequest)
        }

        .catch { _ in Empty() }
        .receive(on: RunLoop.main)

        .assign(to: \.follows, on: self)
        .store(in: &cancellableSet)
        
        $follows
            .flatMap { follows in
            let streamsRequest = StreamsRequest(follows: follows)
                return api.execute(request: streamsRequest)
                    .catch { _ in Just([]) }
        }
        .receive(on: RunLoop.main)
        .sink { streams in
            print(streams)
        }
    }
}
