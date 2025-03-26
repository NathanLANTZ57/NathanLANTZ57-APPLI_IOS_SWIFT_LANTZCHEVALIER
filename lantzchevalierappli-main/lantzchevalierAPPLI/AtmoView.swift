import SwiftUI

struct AtmoView: View {
    @ObservedObject var userChoices: UserChoices
    @State private var selectedType: String? = nil
    @State private var navigateToNextView = false

    var body: some View {
        VStack(spacing: 20) {
            Text("GlobeFinder")
                .font(.custom("Noteworthy-Light", size: 24))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Plutôt quoi ?")
                .font(.custom("Georgia", size: 20))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 40)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                AtmoTypeButton(type: "Nature", icon: "fleur", selectedType: $selectedType)
                AtmoTypeButton(type: "Ville", icon: "batiment", selectedType: $selectedType)
            }
            .padding(.top, 70)
            HStack {
                AtmoTypeButton(type: "Plage", icon: "plage", selectedType: $selectedType)
                AtmoTypeButton(type: "Montagne", icon: "montagne", selectedType: $selectedType)
            }

            Spacer()

            Button(action: {
                if let type = selectedType {
                    print("Type choisi : \(type)")
                    userChoices.destinationType = type
                    navigateToNextView = true
                }
            }) {
                Text("Suivant")
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .background(selectedType != nil ? Color(hex: "#3b6187") : Color.gray)
                    .cornerRadius(10)
            }
            .frame(width: 150, height: 50)
            .disabled(selectedType == nil)
            .background(
                NavigationLink(destination: ActivityView(userChoices: userChoices), isActive: $navigateToNextView) {
                    EmptyView()
                }
                .hidden()
            )
            Spacer()
            NavBarView()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct AtmoTypeButton: View {
    var type: String
    var icon: String
    @Binding var selectedType: String?
    
    var body: some View {
        Button(action: {
            selectedType = type
        }) {
            VStack {
                Text(type)
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(selectedType == type ? Color(hex: "#3b6187") : .white)

                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(selectedType == type ? Color(hex: "#3b6187") : .white)
            }
            .padding()
            .frame(width: 150, height: 100)
            .background(Color.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
        }
        .accessibilityIdentifier(type) // <- Add this line for accessibility
    }
}

