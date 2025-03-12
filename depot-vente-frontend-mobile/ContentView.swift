//
//  ContentView.swift
//  depot-vente-frontend-mobile
//
//  Created by etud on 06/03/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Accueil")
                    .font(.largeTitle)
                    .padding()

                NavigationLink("Voir la Trésorerie", destination: BalanceView())
                    .padding()
                    .buttonStyle(.borderedProminent)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
