import Foundation
import SceneKit

class GlobeViewModel: ObservableObject {
    @Published var cameraZoom: Float = 3.0

    func zoomIn() {
        cameraZoom = max(cameraZoom - 0.5, 1.0)
    }

    func zoomOut() {
        cameraZoom = min(cameraZoom + 0.5, 10.0) 
    }
}
