import Foundation

protocol BalanceServiceProtocol {
    func fetchTreasury(completion: @escaping (Result<Int, Error>) -> Void)
    func fetchTotalDue(completion: @escaping (Result<Int, Error>) -> Void)
    func fetchTotalDepositFees(completion: @escaping (Result<Int, Error>) -> Void)
    func fetchTotalCommissions(completion: @escaping (Result<Int, Error>) -> Void)

}

class BalanceService: BalanceServiceProtocol {
    private let url = URL(string: "https://example.com/users")!
    
    func fetchTreasury(completion: @escaping (Result<Int, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let treasury = try JSONDecoder().decode(Int.self, from: data)
                completion(.success(treasury))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTotalDue(completion: @escaping (Result<Int, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let totalDue = try JSONDecoder().decode(Int.self, from: data)
                completion(.success(totalDue))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTotalDepositFees(completion: @escaping (Result<Int, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let totalDepositFees = try JSONDecoder().decode(Int.self, from: data)
                completion(.success(totalDepositFees))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchTotalCommissions(completion: @escaping (Result<Int, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data"])))
                return
            }
            
            do {
                let totalCommissions = try JSONDecoder().decode(Int.self, from: data)
                completion(.success(totalCommissions))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
