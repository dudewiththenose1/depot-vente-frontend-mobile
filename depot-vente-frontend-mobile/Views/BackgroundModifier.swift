import SwiftUI

struct BackgroundModifier: ViewModifier {
   
    func body(content: Content) -> some View {
        

        content
            .background(
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
            )
    }
}

extension View {
    func applyBackground() -> some View {
        self.modifier(BackgroundModifier())
    }
}
