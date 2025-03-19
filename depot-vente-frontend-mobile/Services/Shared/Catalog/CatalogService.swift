import Foundation
import Combine

class CatalogService {
    private let baseURL = "http://votre-api.com/api/catalog"
    
    func fetchCatalog(query: String?, minPrice: Int?, maxPrice: Int?) -> AnyPublisher<[RealGame], Error> {
        var components = URLComponents(string: baseURL)!
        var queryItems: [URLQueryItem] = []
        
        if let query = query, !query.isEmpty {
            queryItems.append(URLQueryItem(name: "query", value: query))
        }
        if let minPrice = minPrice {
            queryItems.append(URLQueryItem(name: "minPrice", value: String(minPrice)))
        }
        if let maxPrice = maxPrice {
            queryItems.append(URLQueryItem(name: "maxPrice", value: String(maxPrice)))
        }
        
        components.queryItems = queryItems
        
        guard let url = components.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [RealGame].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
