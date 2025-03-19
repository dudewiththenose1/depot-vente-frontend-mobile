import SwiftUI

struct AdminView: View {
    
    @Binding var presentSideMenu: Bool
    @State private var selectedIndex: Int = 0

    var body: some View {
        VStack{
        VStack {
            HStack {
                Button {
                    presentSideMenu.toggle()
                } label: {
                    Image("menu")
                        .resizable()
                        .frame(width: 32, height: 32)
                }
                Spacer()
            }
            .padding(.horizontal, 24)
        }
            TabView(selection: $selectedIndex) {
                NavigationStack {
                    Text("Jeux")
                        .navigationTitle("Games")
                }
                .tabItem {
                    Label("Jeux", systemImage: "gamecontroller")
                }
                .tag(0)
                
                NavigationStack {
                    Text("Utilisateurs")
                        .navigationTitle("Users")
                }
                .tabItem {
                    Label("Utilisateurs", systemImage: "person.3")
                }
                .tag(1)
                
                NavigationStack {
                    Text("Sessions")
                        .navigationTitle("Sessions")
                }
                .tabItem {
                    Label("Sessions", systemImage: "calendar")
                }
                .tag(2)
            }.accentColor(.orange)
        }
    }
}
