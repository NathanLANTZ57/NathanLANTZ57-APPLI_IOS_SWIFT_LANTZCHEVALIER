import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GlobeViewModel()

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    ScrollView {
                        VStack(spacing: 20) {
                            HStack {
                                Text("GlobeFinder")
                                    .font(.custom("Noteworthy-Light", size: 24))
                                    .foregroundColor(.white)
                                    .padding(.leading, 20)
                                    .padding(.top, 10)

                                Spacer()
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)

                            GlobeView(viewModel: viewModel)
                                .frame(maxWidth: .infinity)
                                .aspectRatio(1, contentMode: .fit)

                            ContentSection()
                                .padding()
                            MapView(latitude: 48.858844, longitude: 2.294351, zoomLevel: 10)
                                .edgesIgnoringSafeArea(.all)
                                
                        }
                    }

                    Spacer()

                    NavBarView()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
