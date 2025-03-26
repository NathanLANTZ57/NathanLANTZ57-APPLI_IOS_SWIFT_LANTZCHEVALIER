import SwiftUI

struct ContentSection: View {
    @State private var navigateToTestView = false
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Une idée d'où partir ?")
                .font(.custom("Georgia", size: 18))
                .foregroundColor(.white)
                .padding(.top, 0)
                .padding(.bottom, 10)

            Button(action: {
                navigateToTestView = true
            }) {
                Text("Voyager selon mes envies")
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color(hex: "#3b6187"))
                    .cornerRadius(10)
            }
            .accessibilityIdentifier("Voyager selon mes envies")
            .padding(.bottom, 20)

            NavigationLink(destination: AvantTestView().navigationBarBackButtonHidden(true), isActive: $navigateToTestView) {
                EmptyView()
            }


            Text("Découvrez GlobeFinder, votre compagnon de voyage idéal. Plongez dans un univers où chaque séjour est conçu autour de vos envies. Que vous rêviez d'aventure, de détente ou de découvertes culturelles, GlobeFinder trouve pour vous les destinations parfaites. Explorez librement une sélection de séjours uniques et laissez-vous inspirer. Votre prochaine escapade n'attend que vous !")
                .font(.custom("Georgia", size: 18))
                .foregroundColor(.white)
                .multilineTextAlignment(.leading)
                .lineSpacing(8)
                .padding(.horizontal, 30)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

struct ContentSection_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentSection()
                .background(Color.black)
                .previewLayout(.sizeThatFits)
        }
    }
}
