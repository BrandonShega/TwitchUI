import Foundation

enum TokenStoreKey: String {
    case accessToken = "access_token"
}

struct TokenStore {
    static var token: String? {
        get {
            return UserDefaults.standard.string(for: .accessToken)
        }
        
        set {
            UserDefaults.standard.set(value: newValue, for: .accessToken)
        }
    }
}

extension UserDefaults {
    func string(for key: TokenStoreKey) -> String? {
        return string(forKey: key.rawValue)
    }
    
    func set(value: Any?, for key: TokenStoreKey) {
        return set(value, forKey: key.rawValue)
    }
}
