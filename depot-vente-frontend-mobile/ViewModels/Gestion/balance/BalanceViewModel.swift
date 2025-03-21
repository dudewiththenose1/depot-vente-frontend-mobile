import Combine
import Foundation

class BalanceViewModel: ObservableObject {
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    @Published var treasury: Int = 0
    @Published var totalDue: Int = 0
    @Published var totalDepositFees: Int = 0
    @Published var totalCommissions: Int = 0
    
    private let balanceService: BalanceServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(balanceService: BalanceServiceProtocol = BalanceService()) {
        self.balanceService = balanceService
    }
    
    func fetchTreasury() {
        isLoading = true
        errorMessage = nil
        
        balanceService.fetchTreasury { [weak self] result in
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
