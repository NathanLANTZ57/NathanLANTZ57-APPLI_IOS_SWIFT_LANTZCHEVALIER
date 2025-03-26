import SwiftUI

struct TimeView: View {
    @ObservedObject var userChoices: UserChoices
    @State private var selectedDuration: String? = nil
    @State private var navigateToNextView = false

    var body: some View {
        VStack(spacing: 20) {
            Text("GlobeFinder")
                .font(.custom("Noteworthy-Light", size: 24))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Séjour idéal ?")
                .font(.custom("Georgia", size: 20))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 40)
                .frame(maxWidth: .infinity, alignment: .leading)

            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    DurationButton(duration: "Week-end", description: "(1-3 jours)", icon: "temps", selectedDuration: $selectedDuration)
                    DurationButton(duration: "Semaine", description: "(4-7 jours)", icon: "temps", selectedDuration: $selectedDuration)
                }
                DurationButton(duration: "Vacances", description: "(plus de 8 jours)", icon: "temps", selectedDuration: $selectedDuration)
            }
            .padding(.top, 50)

            Spacer()

            Button(action: {
                if let duration = selectedDuration {
                    print("Durée choisie : \(duration)")
                    userChoices.duration = duration
                    navigateToNextView = true
                }
            }) {
                Text("Terminer le test")
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .background(selectedDuration != nil ? Color(hex: "#3b6187") : Color.gray)
                    .cornerRadius(10)
            }
            .frame(width: 200, height: 50)
            .disabled(selectedDuration == nil)
            .background(
                NavigationLink(destination: ResultView(userChoices: userChoices), isActive: $navigateToNextView) {
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

struct DurationButton: View {
    var duration: String
    var description: String
    var icon: String
    @Binding var selectedDuration: String?
    
    var body: some View {
        Button(action: {
            selectedDuration = duration
        }) {
            VStack(spacing: 5) {
                Text(duration)
                    .font(.custom("Georgia", size: 16))
                    .foregroundColor(selectedDuration == duration ? Color(hex: "#3b6187") : .white)
                Text(description)
                    .font(.custom("Georgia", size: 12))
                    .foregroundColor(selectedDuration == duration ? Color(hex: "#3b6187") : .white)
                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(selectedDuration == duration ? Color(hex: "#3b6187") : .white)
            }
            .padding()
            .frame(width: 140, height: 140)
            .background(Color.black)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.white, lineWidth: 1)
            )
        }
    }
}
