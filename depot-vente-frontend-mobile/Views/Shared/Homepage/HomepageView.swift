import SwiftUI

struct HomepageView: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack{
            Image("background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.3)
            VStack{
                
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
                VStack {
                    Spacer()
                    Text("Session en cours")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Button(action: {}) {
                        Text("Accédez au catalogue !")
                            .padding()
                            .foregroundColor(.white)
                            .background(.orange)
                            .cornerRadius(10)
                    }
                    .shadow(color: .red, radius: 15, y: 5)
                    
                    
                    Spacer()
                }.padding(.bottom, 40)
                Spacer()
            }
            .padding(.horizontal, 24)
            
        }
        
    }
}

