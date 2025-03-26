import SwiftUI
import SceneKit

struct GlobeView: UIViewRepresentable {
    var viewModel: GlobeViewModel

    func makeUIView(context: Context) -> SCNView {
        let sceneView = SCNView()
        sceneView.scene = SCNScene()

        let globe = SCNSphere(radius: 1.3)
        globe.firstMaterial?.diffuse.contents = UIImage(named: "8081_earthmap4k.jpg")

        let globeNode = SCNNode(geometry: globe)
        sceneView.scene?.rootNode.addChildNode(globeNode)

        let rotateAction = SCNAction.rotateBy(x: 0, y: CGFloat(Double.pi * 2), z: 0, duration: 20)
        let repeatAction = SCNAction.repeatForever(rotateAction)
        globeNode.runAction(repeatAction)

        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: viewModel.cameraZoom)
        sceneView.scene?.rootNode.addChildNode(cameraNode)

        sceneView.allowsCameraControl = true

        sceneView.backgroundColor = UIColor.clear

        let scrollGesture = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.handleScroll(_:)))
        sceneView.addGestureRecognizer(scrollGesture)

        return sceneView
    }

    func updateUIView(_ uiView: SCNView, context: Context) {
        if let cameraNode = uiView.scene?.rootNode.childNodes.first(where: { $0.camera != nil }) {
            cameraNode.position.z = viewModel.cameraZoom
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(viewModel: viewModel)
    }

    class Coordinator: NSObject {
        var viewModel: GlobeViewModel

        init(viewModel: GlobeViewModel) {
            self.viewModel = viewModel
        }

        @objc func handleScroll(_ gesture: UIPanGestureRecognizer) {
            let translation = gesture.translation(in: gesture.view)
            if translation.y > 0 {
                viewModel.zoomIn()
            } else {
                viewModel.zoomOut()
            }
        }
    }
}
