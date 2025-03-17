import Combine
import Foundation

class SellersViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var email : String = ""
    @Published var clientDetails : ClientDetails
    
    private let sellersService: SellersService
    private var cancellables = Set<AnyCancellable>()
    
    init(sellersService: SellersService = SellersService()) {
        self.sellersService = sellersService
    }
    
    //Fetch all the treasury information needed
    func fetchTreasury() {
        isLoading = true
        errorMessage = nil
        
        sellersService.fetchTreasury { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let treasury):
                    self?.treasury = treasury
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
        balanceService.fetchTotalDue { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let totalDue):
                    self?.totalDue = totalDue
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
        balanceService.fetchTotalDepositFees { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let totalDepositFees):
                    self?.totalDepositFees = totalDepositFees
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
        balanceService.fetchTotalCommissions { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let totalCommissions):
                    self?.totalCommissions = totalCommissions
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
