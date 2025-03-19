import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""
    
    @Binding var presentSideMenu: Bool
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.3)
            VStack {
                
                HStack{
                    Button{
                        presentSideMenu.toggle()
                    } label: {
                        Image("menu")
                            .resizable()
                            .frame(width: 32, height: 32)
                    }
                    Spacer()
                }
                
                
                Spacer()
                
                VStack {
                    TextField(
                        "utilisateur",
                        text: $email
                    )
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .padding(.top, 20)
                    
                    Divider()
                    
                    SecureField(
                        "Mot de Passe",
                        text: $password
                    )
                    .textContentType(.password)
                    .padding(.top, 20)
                    
                    Divider()
                }
                
                Spacer()
                Button("Se connecter") {
                   login()
               }
                .font(.system(size: 24, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, maxHeight: 60)
                .foregroundColor(Color.white)
                .background(Color.blue)
                .cornerRadius(10)
                
                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 24)
        }
    }
    private func login() {
        AuthService.shared.login(email: email, password: password) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    // Redirection vers l'écran principal
                    print("Authentification réussie")
                case .failure(let error):
                    handleLoginError(error)
                }
            }
        }
    }
    
    private func handleLoginError(_ error: Error) {
        switch error {
        case AuthError.unauthorized:
            errorMessage = "Identifiants incorrects"
        default:
            errorMessage = "Erreur de connexion"
        }
    }
}
