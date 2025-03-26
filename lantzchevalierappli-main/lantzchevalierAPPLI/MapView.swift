import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    let latitude: Double
    let longitude: Double
    let zoomLevel: Int
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: coordinate,
                                        latitudinalMeters: CLLocationDistance(zoomLevelToMeters(zoomLevel: zoomLevel)),
                                        longitudinalMeters: CLLocationDistance(zoomLevelToMeters(zoomLevel: zoomLevel)))
        uiView.setRegion(region, animated: true)
    }
    
    func zoomLevelToMeters(zoomLevel: Int) -> Double {

        let maxZoomLevel: Double = 20.0
        let zoom = Double(zoomLevel)
        return 1000 * pow(2, (maxZoomLevel - zoom))
    }
}
