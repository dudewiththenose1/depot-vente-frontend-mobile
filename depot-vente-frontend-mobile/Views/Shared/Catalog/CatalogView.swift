
import SwiftUI

struct CatalogView: View {
    @State var sliderPosition: ClosedRange<Float> = 3...8
    
    @StateObject var viewModel = CatalogViewModel()
    var body: some View {
        NavigationView {
            List {
                Text("Prix")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.black)
                RangedSliderView(value: $sliderPosition, bounds: 1...10)
                    .frame(height:50)
                ForEach((1...10), id: \.self) { _ in
                    HStack {
                        ZStack {
                            Circle()
                                .frame(width: 50, height: 50)
                                .foregroundColor(.black)
                            Text("TSLA")
                                .font(.system(size: 12, weight: .bold))
                                .foregroundColor(.white)
                        }
                        VStack(alignment: .leading) {
                            HStack {
                                Text("Monopoly"+","+"Hasbro")
                                    .font(.system(size: 16, weight: .semibold))
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .padding(.bottom,1)
                                Spacer()
                                Text("15"+"€")
                                    .font(.system(size: 14, weight: .semibold))
                            }
                            
                            Text("Vendeur : "+"Roger")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .truncationMode(.tail)
                            Text("Quantité "+"restant(s)")
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                                .lineLimit(1)
                                .truncationMode(.tail)
                        }
                        Spacer()
                    }
                    .listRowInsets(EdgeInsets())
                    .padding(.vertical,16)
                }
            }
            .navigationTitle("Catalogue")
            .scrollContentBackground(.hidden)
            .searchable(text: $viewModel.searchText)
        }
    }
}

struct NotificationsView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}

