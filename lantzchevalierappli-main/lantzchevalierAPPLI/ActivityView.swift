import SwiftUI

struct ActivityView: View {
    @ObservedObject var userChoices: UserChoices
    @State private var selectedActivity: String? = nil
    @State private var navigateToNextView = false

    var body: some View {
        VStack(spacing: 20) {
            Text("GlobeFinder")
                .font(.custom("Noteworthy-Light", size: 24))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text("Votre activité favorite ?")
                .font(.custom("Georgia", size: 20))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 40)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                ActivityTypeButton(activity: "Sport", icon: "sport", selectedActivity: $selectedActivity)
                ActivityTypeButton(activity: "Culture", icon: "livre", selectedActivity: $selectedActivity)
            }
            .padding(.top, 70)
            HStack {
                ActivityTypeButton(activity: "Gastronomie", icon: "gastro", selectedActivity: $selectedActivity)
                ActivityTypeButton(activity: "Relaxation", icon: "zen", selectedActivity: $selectedActivity)
            }

            Spacer()

            Button(action: {
                if let activity = selectedActivity {
                    print("Activité choisie : \(activity)")
                    userChoices.activity = activity
                    navigateToNextView = true
                }
            }) {
                Text("Suivant")
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(.white)
                    .padding()
                    .background(selectedActivity != nil ? Color(hex: "#3b6187") : Color.gray)
                    .cornerRadius(10)
            }
            .frame(width: 150, height: 50)
            .disabled(selectedActivity == nil)
            .background(
                NavigationLink(destination: TimeView(userChoices: userChoices), isActive: $navigateToNextView) {
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

struct ActivityTypeButton: View {
    var activity: String
    var icon: String
    @Binding var selectedActivity: String?
    
    var body: some View {
        Button(action: {
            selectedActivity = activity
        }) {
            VStack {
                Text(activity)
                    .font(.custom("Georgia", size: 18))
                    .foregroundColor(selectedActivity == activity ? Color(hex: "#3b6187") : .white)

                Image(icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .foregroundColor(selectedActivity == activity ? Color(hex: "#3b6187") : .white)
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
        .accessibilityIdentifier(activity)
    }
}

