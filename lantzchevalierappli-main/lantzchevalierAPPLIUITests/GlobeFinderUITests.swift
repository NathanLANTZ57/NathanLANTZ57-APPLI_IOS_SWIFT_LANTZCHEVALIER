import SwiftUI
import XCTest
@testable import lantzchevalierAPPLI

class GlobeFinderUITests: XCTestCase {

    var app: XCUIApplication!

    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launch()
        continueAfterFailure = false
    }

    func testUserFullNavigationAndFetchSuggestions() throws {

        let ideeLabel = app.staticTexts["Une idée d'où partir ?"]
        XCTAssertTrue(ideeLabel.waitForExistence(timeout: 5), "Le label 'Une idée d'où partir ?' devrait s'afficher")

        let voyagerButton = app.buttons["Voyager selon mes envies"]
        XCTAssertTrue(voyagerButton.exists, "Le bouton 'Voyager selon mes envies' n'existe pas.")
        voyagerButton.tap()

        let avantTestViewText = app.staticTexts["Trouve ton voyage de rêve en effectuant ce test !"]
        XCTAssertTrue(avantTestViewText.waitForExistence(timeout: 5), "La vue du test n'a pas apparu")

        let commencerLeTestButton = app.buttons["Commencer le test"]
        XCTAssertTrue(commencerLeTestButton.exists, "Le bouton 'Commencer le test' n'existe pas.")
        commencerLeTestButton.tap()

        let travelViewText = app.staticTexts["Où partir ?"]
        XCTAssertTrue(travelViewText.waitForExistence(timeout: 5), "La vue de sélection de destination n'est pas apparue.")

        let destinationButton = app.buttons["Paris"]
        XCTAssertTrue(destinationButton.exists, "Le bouton 'Paris' n'existe pas.")
        destinationButton.tap()
    }




    func testFetchTravelSuggestionsWithFailure() throws {
        XCTAssertTrue(app.staticTexts["Une idée d'où partir ?"].exists)

        let voyagerButton = app.buttons["Voyager selon mes envies"]
        XCTAssertTrue(voyagerButton.exists)
        voyagerButton.tap()

        let commencerLeTestButton = app.buttons["Commencer le test"]
        XCTAssertTrue(commencerLeTestButton.exists)
        commencerLeTestButton.tap()

        let destinationButton = app.buttons["Unknown"]
        XCTAssertFalse(destinationButton.exists, "Le bouton de destination 'Unknown' ne devrait pas exister.")
    }
}

