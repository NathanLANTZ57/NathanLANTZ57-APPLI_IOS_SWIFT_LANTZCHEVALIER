import SwiftUI
import Combine
import Alamofire

struct ResultView: View {
    @ObservedObject var userChoices: UserChoices
    @State public var travelSuggestions: [TravelSuggestion] = []
    @State private var isLoading = false
    @State public var errorMessage: String?
    @State private var selectedSuggestionID: String?

    var body: some View {
        VStack {
 
            Text("GlobeFinder")
                .font(.custom("Noteworthy-Light", size: 24))
                .foregroundColor(.white)
                .padding(.top, 10)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)

     
            if isLoading {
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(2)
                    .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            } else if let error = errorMessage {
                Text(error)
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else if travelSuggestions.isEmpty {
                Text("Aucune suggestion trouvée")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
            } else {
                ScrollView {
                    VStack(spacing: 20) {
                        ForEach(travelSuggestions) { suggestion in
                            TravelSuggestionRow(
                                suggestion: suggestion,
                                isSelected: selectedSuggestionID == suggestion.id,
                                onSelect: {
                                    selectedSuggestionID = suggestion.id
                                }
                            )
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)

                            Divider()
                                .background(Color.white)
                        }

                        NavigationLink(destination: MapView(latitude: getCoordinatesForDestination(userChoices.destination).0,
                                                             longitude: getCoordinatesForDestination(userChoices.destination).1,
                                                             zoomLevel: 14)) {
                            Text("Voir l'endroit du séjour")
                                .font(.custom("Georgia", size: 18))
                                .foregroundColor(.black)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "#3b6187"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 20)

                        NavigationLink(destination: AvantTestView().navigationBarBackButtonHidden(true)) {
                            Text("Retour au test")
                                .font(.custom("Georgia", size: 18))
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color(hex: "#acc4ce"))
                                .cornerRadius(10)
                        }
                        .padding(.horizontal, 50)
                        .padding(.top, 0)
                    }
                }
                .padding(.horizontal, 20)
            }

            Spacer()
            NavBarView()
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .onAppear {
            fetchTravelSuggestions()
        }
    }

  
    func fetchTravelSuggestions() {
        isLoading = true
        errorMessage = nil

        let apiKey = "fsq3KCe/k7fkEXAZhhMtTIeFjet/4Kog6XC1usUUhTxx4x0="
        let baseURL = "https://api.foursquare.com/v3/places/search"
        
        let (latitude, longitude) = getCoordinatesForDestination(userChoices.destination)
        
        let categories = mapUserChoicesToFoursquareCategories(
            destinationType: userChoices.destinationType,
            activity: userChoices.activity
        )
        
        let headers: HTTPHeaders = [
            "Authorization": apiKey,
            "Accept": "application/json"
        ]
        
        let parameters: [String: Any] = [
            "ll": "\(latitude),\(longitude)",
            "radius": 50000,
            "categories": categories,
            "limit": 50
        ]
        
        AF.request(baseURL, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: FoursquareResponse.self) { response in
                self.isLoading = false
                
                switch response.result {
                case .success(let foursquareResponse):
                    let places = foursquareResponse.results
                    self.travelSuggestions = self.createTravelSuggestions(from: places)
                case .failure(let error):
                    self.errorMessage = "Erreur réseau: \(error.localizedDescription)"
                }
            }
    }
    

    func getCoordinatesForDestination(_ destination: String) -> (Double, Double) {
        switch destination {
        case "Paris":
            return (48.8566, 2.3522)
        case "Marseille":
            return (43.2965, 5.3698)
        case "Chamonix":
            return (45.9237, 6.8694)
        case "Tokyo":
            return (35.6762, 139.6503)
        case "Bali":
            return (-8.3405, 115.0920)
        case "Chongqing":
            return (29.4316, 106.9123)
        case "New York":
            return (40.7128, -74.0060)
        case "Hampton Beach":
            return (42.9077, -70.8117)
        case "Jackson Hole":
            return (43.4799, -110.7624)
        case "Sydney":
            return (-33.8688, 151.2093)
        case "Melbourne":
            return (-37.8136, 144.9631)
        case "Canberra":
            return (-35.2809, 149.1300)
        case "Johannesburg":
            return (-26.2041, 28.0473)
        case "Durban":
            return (-29.8587, 31.0218)
        case "Kimberley":
            return (-28.7282, 24.7499)
        case "Bombay":
            return (19.0760, 72.8777)
        case "Chennai":
            return (13.0827, 80.2707)
        case "Pune":
            return (18.5204, 73.8567)
        default:
            return (0.0, 0.0)
        }
    }

   
    func mapUserChoicesToFoursquareCategories(destinationType: String, activity: String) -> String {
        var categories: [String] = []
        
        switch destinationType.lowercased() {
        case "nature":
            categories += ["16000", "16003"]
        case "ville":
            categories += ["10000", "13000"]
        case "plage":
            categories += ["16043"]
        case "montagne":
            categories += ["16021"]
        default:
            break
        }
        
        switch activity.lowercased() {
        case "sport":
            categories += ["18000"]
        case "culture":
            categories += ["10000", "12000"]
        case "gastronomie":
            categories += ["13000"]
        case "relaxation":
            categories += ["14000"]
        default:
            break
        }
        
        return categories.joined(separator: ",")
    }

    
    
    func createTravelSuggestions(from places: [FoursquarePlace]) -> [TravelSuggestion] {
        let numberOfSuggestions = min(5, places.count / 3)
        var suggestions: [TravelSuggestion] = []
        
        for i in 0..<numberOfSuggestions {
            let startIndex = i * 3
            let endIndex = min(startIndex + 3, places.count)
            let placeGroup = Array(places[startIndex..<endIndex])
            
            let title = "Séjour \(userChoices.destination) - \(userChoices.activity)"
            let description = placeGroup.map { $0.name }.joined(separator: ", ")
            
            suggestions.append(TravelSuggestion(
                id: UUID().uuidString,
                title: title,
                description: "Visitez : \(description)"
            ))
        }
        
        return suggestions
    }
}


struct FoursquareResponse: Codable {
    let results: [FoursquarePlace]
}

struct FoursquarePlace: Codable {
    let fsq_id: String
    let name: String
    let categories: [FoursquareCategory]
}

struct FoursquareCategory: Codable {
    let id: Int
    let name: String
}

struct TravelSuggestion: Identifiable {
    let id: String
    let title: String
    let description: String
}

struct TravelSuggestionRow: View {
    let suggestion: TravelSuggestion
    let isSelected: Bool
    let onSelect: () -> Void

    var body: some View {
        VStack(alignment: .leading) {
            Text(suggestion.title)
                .font(.headline)
                .foregroundColor(isSelected ? Color(hex: "#3b6187") : .white)

        
            Text(suggestion.description)
                .font(.subheadline)
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
                .onTapGesture {
                    onSelect() 
                }
        }
    }
}
