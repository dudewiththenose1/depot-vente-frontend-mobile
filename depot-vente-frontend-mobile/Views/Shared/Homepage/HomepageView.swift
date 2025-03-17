import SwiftUI

struct HomepageView: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
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
                    Text("Button with Shadow")
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

