import SwiftUI

struct NavBarView: View {
    var body: some View {
        HStack {
            Spacer(minLength: 50)

            NavigationLink(destination: MapView(latitude: 48.858844, longitude: 2.294351, zoomLevel: 10)) {
                Image("gps")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
            }

            Spacer(minLength: 70)

            NavigationLink(destination: ContentView().toolbar(.hidden, for: .navigationBar)) {
                Image("globe")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
            }

            Spacer(minLength: 70)

            NavigationLink(destination: AvantTestView().toolbar(.hidden, for: .navigationBar)) {
                Image("test")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 45, height: 45)
            }

            Spacer(minLength: 50)
        }
        .padding(.top, 20)
        .background(Color.gray.opacity(0.2))
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
            .previewLayout(.sizeThatFits)
    }
}
