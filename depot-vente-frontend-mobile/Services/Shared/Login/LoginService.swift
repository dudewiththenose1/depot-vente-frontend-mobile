import Foundation
import Security

class AuthService {
    static let shared = AuthService()
    private let keychainAccount = "com.your.app.auth"
    private let authTokenKey = "authToken"
    
    // MARK: - Gestion du token
    var authToken: String? {
        get {
            var query = keychainQuery
            query[kSecMatchLimit as String] = kSecMatchLimitOne
            query[kSecReturnData as String] = kCFBooleanTrue
            
            var dataTypeRef: AnyObject?
            let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
            
            if status == errSecSuccess, let data = dataTypeRef as? Data {
                return String(data: data, encoding: .utf8)
            }
            return nil
        }
        set {
            if let newValue = newValue {
                let data = newValue.data(using: .utf8)!
                var query = keychainQuery
                query[kSecValueData as String] = data
                SecItemAdd(query as CFDictionary, nil)
            } else {
                let query = keychainQuery
                SecItemDelete(query as CFDictionary)
            }
        }
    }
    
    private var keychainQuery: [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: authTokenKey,
            kSecAttrService as String: keychainAccount
        ]
    }
    
    // MARK: - Login
    func login(email: String, password: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let loginRequest = LoginRequest(email: email, password: password)
        
        guard let url = URL(string: "https://votre-api.com/login") else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONEncoder().encode(loginRequest)
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(URLError(.badServerResponse)))
                return
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                if let data = data,
                   let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data) {
                    // Stockage du token
                    self?.authToken = loginResponse.token
                    // Configuration des cookies si nécessaire
                    self?.handleCookies(response: httpResponse)
                    completion(.success(true))
                } else {
                    completion(.failure(URLError(.cannotParseResponse)))
                }
            case 401:
                completion(.failure(AuthError.unauthorized))
            default:
                completion(.failure(URLError(.unknown)))
            }
        }
        task.resume()
    }
    
    // MARK: - Gestion des cookies
    private func handleCookies(response: HTTPURLResponse) {
        guard let url = response.url else { return }
        let cookies = HTTPCookie.cookies(withResponseHeaderFields: response.allHeaderFields as? [String: String] ?? [:], for: url)
        
        for cookie in cookies {
            HTTPCookieStorage.shared.setCookie(cookie)
        }
    }
    
    // MARK: - Logout
    func logout() {
        authToken = nil
        clearAllCookies()
    }
    
    private func clearAllCookies() {
        guard let cookies = HTTPCookieStorage.shared.cookies else { return }
        for cookie in cookies {
            HTTPCookieStorage.shared.deleteCookie(cookie)
        }
    }
    
    // MARK: - Vérification authentification
    var isAuthenticated: Bool {
        authToken != nil
    }
}

enum AuthError: Error {
    case unauthorized
}

extension URLRequest {
    mutating func addAuthHeader() {
        if let token = AuthService.shared.authToken {
            addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
    }
}
