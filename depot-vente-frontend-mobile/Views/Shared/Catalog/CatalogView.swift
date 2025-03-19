
import SwiftUI

struct CatalogView: View {
    
    @StateObject var viewModel = CatalogViewModel()
    var body: some View {
        NavigationView {
            VStack{
                VStack(alignment: .leading) {
                    Text("Prix")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.black)
                    RangedSliderView(value: $viewModel.priceRange, bounds: 0...100)
                        .frame(height:50)
                        .frame(width: 300)
                        .onChange(of: viewModel.priceRange) { _ in
                            viewModel.fetchCatalog()
                        }
                    Text("De \(Int(viewModel.priceRange.lowerBound))€ à \(Int(viewModel.priceRange.upperBound))€")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding(.horizontal)
                    
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else if let error = viewModel.errorMessage {
                    ErrorView(error: error)
                } else if viewModel.games.isEmpty {
                    Text("Aucun jeu trouvé")
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    List(viewModel.games) { game in
                        GameRow(game: game)
                    }
                    .listStyle(.plain)
                }
                Spacer()
            }
            .navigationTitle("Catalogue")
            .searchable(text: $viewModel.searchText, prompt: "Rechercher un jeu")
            
        }
        
    }
}

struct GameRow: View {
    let game: RealGame
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.black)
                Text(game.gameName.prefix(2))
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading) {
                HStack {
                    Text("\(game.gameName), \(game.gameEditor)")
                        .font(.headline)
                        .lineLimit(1)
                    Spacer()
                    Text("\(game.unit_price)€")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Text("Quantité : \(game.qty)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 8)
    }
}

struct ErrorView: View {
    let error: String
    
    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .foregroundColor(.red)
            Text("Erreur")
                .font(.headline)
            Text(error)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
        }
        .padding()
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}

