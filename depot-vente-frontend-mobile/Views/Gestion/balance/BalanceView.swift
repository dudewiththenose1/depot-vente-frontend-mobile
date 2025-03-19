import SwiftUI

struct BalanceView: View {
    @ObservedObject var viewModel = BalanceViewModel()
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading treasury...")
                } else if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .multilineTextAlignment(.center)
                } else {
                    VStack {
                        Text("Bilans")
                            .font(.largeTitle)
                            .padding()
                        Text("Trésorerie Totale \(viewModel.treasury)")
                        Text("Somme due aux vendeurs \(viewModel.totalDue)")
                        Text("Frais de dépot encaissés \(viewModel.totalDepositFees)")
                        Text("Commission prélevés \(viewModel.totalCommissions)")
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchTreasury()
        }
    }

}
