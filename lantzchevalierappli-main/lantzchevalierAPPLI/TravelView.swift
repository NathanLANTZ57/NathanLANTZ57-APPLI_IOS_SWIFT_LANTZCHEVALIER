import SwiftUI

struct TravelView: View {
    @ObservedObject var userChoices: UserChoices
    @State private var selectedLocation: String? = nil
    @State private var navigateToNextView = false

    var body: some View {
        VStack(spacing: 20) {
            Text("GlobeFinder")
                .font(.custom("Noteworthy-Light", size: 24))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Où partir ?")
                .font(.custom("Georgia", size: 20))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 40)
                .frame(maxWidth: .infinity, alignment: .leading)

            ScrollView {
                VStack(spacing: 10) {
                    HStack {
                        DestinationButton(destination: "Paris", icon: "paris", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Marseille", icon: "marseille", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Chamonix", icon: "chamonix", selectedLocation: $selectedLocation)
                    }
                    HStack {
                        DestinationButton(destination: "Tokyo", icon: "tokyo", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Bali", icon: "bali", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Chongqing", icon: "padoge", selectedLocation: $selectedLocation)
                    }
                    HStack {
                        DestinationButton(destination: "New York", icon: "statut", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Hampton Beach", icon: "hampton", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Jackson Hole", icon: "jackson", selectedLocation: $selectedLocation)
                    }
                    HStack {
                        DestinationButton(destination: "Sydney", icon: "opera", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Melbourne", icon: "melbourne", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Canberra", icon: "canberra", selectedLocation: $selectedLocation)
                    }
                    HStack {
                        DestinationButton(destination: "Johannesburg", icon: "johannesbourg", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Durban", icon: "elephant", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Kimberley", icon: "kimberley", selectedLocation: $selectedLocation)
                    }
                    HStack {
                        DestinationButton(destination: "Bombay", icon: "bombay", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Chennai", icon: "chennai", selectedLocation: $selectedLocation)
                        DestinationButton(destination: "Pune", icon: "pune", selectedLocation: $selectedLocation)
                    }
                }
            }

            Spacer()

            Button(action: {
                if let destination = selectedLocation {
                    print("Destination choisie : \(destination)")
                    userChoices.destination = destination
                    navigateToNextView = true
                }
            }) {
                Text("Suivant")
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .background(selectedLocation != nil ? Color(hex: "#3b6187") : Color.gray)
                    .cornerRadius(10)
            }
            .frame(width: 150, height: 50)
            .cornerRadius(25)
            .disabled(selectedLocation == nil)
            .background(
                NavigationLink(destination: AtmoView(userChoices: userChoices), isActive: $navigateToNextView) {
                    EmptyView()
                }
                .hidden()
            )
            
            NavBarView()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct DestinationButton: View {
    var destination: String
    var icon: String
    @Binding var selectedLocation: String?
    
    var body: some View {
        Button(action: {
            selectedLocation = destination
        }) {
            VStack {
                Text(destination)
                    .font(.custom("Georgia", size: 14))
                    .foregroundColor(selectedLocation == destination ? Color(hex: "#3b6187") : .white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)

            
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(selectedLocation == destination ? Color(hex: "#3b6187") : .white)
            }
            .padding(5)
            .frame(width: 100, height: 100)
            .background(Color.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
        }
    }
}

