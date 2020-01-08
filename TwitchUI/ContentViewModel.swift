import Foundation
import AuthenticationServices
import Keys

class ContentViewModel: NSObject, ObservableObject, Identifiable {
    @Published var loggedIn = false
    
    var presentingWindow: UIWindow?
    var currentUser: User?
    var api = API(network: URLSession.shared, baseURL: Config.baseUrl)
    
    func login() {
        let keys = TwitchUIKeys()
        let clientId = keys.twitchAPIClientID
        let redirectUri = "twitchui:"
        let responseType = "token"
        
        let registrationUrl = "https://id.twitch.tv/oauth2/authorize?client_id=\(clientId)&redirect_uri=\(redirectUri)&response_type=\(responseType)&scope="
        
        if let url = URL(string: registrationUrl) {
            let session = ASWebAuthenticationSession(url: url, callbackURLScheme: nil) { (callbackUrl, error) in
                guard error == nil,
                    let callbackUrl = callbackUrl
                    else { return }
                
                if let urlString = callbackUrl.absoluteString.removingPercentEncoding?.replacingOccurrences(of: "#", with: "?"),
                    let components = NSURLComponents(string: urlString),
                    let token = components.queryItems?.filter({ $0.name == "access_token" }).first?.value {
                    TokenStore.token = token
                    self.loggedIn = true
                }
            }
            session.presentationContextProvider = self
            session.start()
        }
    }
}

extension ContentViewModel: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return presentingWindow ?? ASPresentationAnchor()
    }
}
