import Foundation

private struct ClientRequest: Codable {
    let id: String
    let session: Session
}

class SellersService {
    private let baseURL = "https://ton-backend.com/gestion"
    func searchEmails(email: String) async throws -> [Client] {
        let url = URL(string: "\(baseURL)/client-list")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ["email": email]
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        let clients = try JSONDecoder().decode([Client].self, from: data)
        
        return clients
        
    }
    
    func getClientInfo(id: String, session: Session) async throws -> ClientDetails {
        let url = URL(string: "\(baseURL)/client-info")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body = ClientRequest(id: id, session: session)
        request.httpBody = try JSONEncoder().encode(body)

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(ClientDetails.self, from: data)
    }
    
    func getAllSession() async throws -> [Session] {
        let url = URL(string: "\(baseURL)/session")!
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let sessions = try JSONDecoder().decode([Session].self, from: data)
        return sessions
    }
}
