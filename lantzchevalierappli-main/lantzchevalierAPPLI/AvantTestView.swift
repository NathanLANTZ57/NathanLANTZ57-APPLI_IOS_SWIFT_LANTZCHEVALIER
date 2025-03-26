import SwiftUI

struct AvantTestView: View {
    @StateObject private var userChoices = UserChoices()
    @State private var navigateToTravelView = false
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("GlobeFinder")
                    .font(.custom("Noteworthy-Light", size: 24))
                    .foregroundColor(.white)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("Trouve ton voyage de rêve en effectuant ce test !")
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal, 20)
                    .padding(.top, 30)
                
                VStack {
                    Image(systemName: "hourglass")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.white)
                    
                    Text("Durée estimée :\n2 minutes")
                        .font(.custom("Georgia", size: 18))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.top, 20)
                }
                .frame(width: 200, height: 200)
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
                .padding(.top, 45)

                Button(action: {
                    navigateToTravelView = true
                }) {
                    Text("Commencer le test")
                        .font(.custom("Georgia", size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color(hex: "#3b6187"))
                        .cornerRadius(10)
                        .padding(.top, 30)
                }

                Spacer()
                NavigationLink(destination: TravelView(userChoices: userChoices), isActive: $navigateToTravelView) {
                    EmptyView()
                }
                NavBarView()
            }
            .background(Color.black.edgesIgnoringSafeArea(.all))
        }
    }
}
