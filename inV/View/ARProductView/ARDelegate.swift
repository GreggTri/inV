//
//  ARDelegate.swift
//  inV
//
//  Created by Gregg Trimarchi on 12/13/21.
//

import Foundation
import ARKit
import UIKit

class ARDelegate: NSObject, ARSCNViewDelegate, ObservableObject {
    @Published var message:String = "starting AR"
    
    var contentNode: SCNNode?
    
    var occlusionNode: SCNNode!
    
    func setARView(_ arView: ARSCNView) {
        self.arView = arView
        
        guard ARFaceTrackingConfiguration.isSupported else{
            fatalError("Face Tracking is not supported on this device")
        }
        
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true;
        arView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        arView.delegate = self
        arView.scene = SCNScene()
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        print("camera did change \(camera.trackingState)")
        switch camera.trackingState {
        case .limited(_):
            message = "tracking limited"
        case .normal:
            message =  "tracking ready"
        case .notAvailable:
            message = "cannot track"
        }
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let device = arView?.device else{ return nil }
        

        let faceGeometry = ARSCNFaceGeometry(device: device)
        faceGeometry?.firstMaterial!.colorBufferWriteMask = []
        
        let occlusionNode = SCNNode(geometry: faceGeometry)
        occlusionNode.renderingOrder = -1
        
        let sunglasses = SCNReferenceNode(named: "overlayModel")
        
        contentNode = SCNNode()
        contentNode!.addChildNode(sunglasses)
        contentNode!.addChildNode(occlusionNode)
        
        return contentNode
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        
        guard let faceGeometry = occlusionNode?.geometry as? ARSCNFaceGeometry,
            let faceAnchor = anchor as? ARFaceAnchor
            else { return }
            
        faceGeometry.update(from: faceAnchor.geometry)
    }
    
    // MARK: - Private
    private var arView: ARSCNView?
    private var circles:[SCNNode] = []
    private var trackedNode:SCNNode?
}

extension SCNReferenceNode {
    convenience init(named resourceName: String, loadImmediately: Bool = true) {
        let url = Bundle.main.url(forResource: resourceName, withExtension: "scn")!
        self.init(url: url)!
        if loadImmediately {
            self.load()
        }
    }
}
