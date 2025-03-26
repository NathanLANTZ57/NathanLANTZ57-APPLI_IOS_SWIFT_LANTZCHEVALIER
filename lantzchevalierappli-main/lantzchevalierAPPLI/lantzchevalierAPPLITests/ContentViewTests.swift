import XCTest
import SwiftUI
@testable import lantzchevalierAPPLI

class ContentViewTests: XCTestCase {

    func testContentSectionTextPresence() {
        let contentSection = ContentSection()
        
        let expectedText = "Découvrez GlobeFinder, votre compagnon de voyage idéal. Plongez dans un univers où chaque séjour est conçu autour de vos envies. Que vous rêviez d'aventure, de détente ou de découvertes culturelles, GlobeFinder trouve pour vous les destinations parfaites. Explorez librement une sélection de séjours uniques et laissez-vous inspirer. Votre prochaine escapade n'attend que vous !"

        let controller = UIHostingController(rootView: contentSection)
        controller.view.setNeedsLayout()
        controller.view.layoutIfNeeded()
        
        let foundText = controller.view.subviews
            .flatMap { $0.subviews }
            .compactMap { $0 as? UILabel }
            .first(where: { $0.text == expectedText })?.text
    }
}
