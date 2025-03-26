import Foundation

class UserChoices: ObservableObject {
    @Published var destination: String = ""
    @Published var destinationType: String = ""
    @Published var activity: String = ""
    @Published var duration: String = ""
}
