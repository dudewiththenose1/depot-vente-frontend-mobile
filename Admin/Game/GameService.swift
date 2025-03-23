import Foundation
import Combine

class GameService {
    private let baseURL = "\(Environment.baseURL)/admin/games"
    private let gestionURL = "\(Environment.baseURL)/gestion/games"

    
    func fetchGames(query: String?) -> AnyPublisher<[Game], Error> {
        var components = URLComponents(string: gestionURL)!
        if let query = query, !query.isEmpty {
            components.queryItems = [URLQueryItem(name: "query", value: query)]
        }
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [Game].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func createGame(name: String, editor: String) -> AnyPublisher<Void, Error> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "name": name,
            "editor": editor
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in () }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func updateGame(id: Int, name: String?, editor: String?) -> AnyPublisher<Void, Error> {
        guard let url = URL(string: "\(baseURL)?id=\(id)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var body: [String: Any] = [:]
        if let name = name { body["name"] = name }
        if let editor = editor { body["editor"] = editor }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in () }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func deleteGame(id: Int) -> AnyPublisher<Void, Error> {
        guard let url = URL(string: "\(baseURL)?id=\(id)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map { _ in () }
            .mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
}
