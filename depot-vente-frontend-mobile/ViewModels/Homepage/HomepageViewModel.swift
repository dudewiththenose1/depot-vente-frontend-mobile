import Combine
import Foundation

class HomepageViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var currentSession: Session?
    
    private let homepageService: HomepageService
    
    init(service: HomepageService = HomepageService()) {
        self.homepageService = service
        fetchSession()
    }
    
    func fetchSession() {
        isLoading = true
        errorMessage = nil
        
        homepageService.fetchCurrentSession { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let session):
                    self?.currentSession = session
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
