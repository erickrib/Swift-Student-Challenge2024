//
//  GameScene.swift
//
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SpriteKit
import SwiftUI

protocol ModalPresenter: AnyObject {
    func showCustomModal()
}

class GameScene: SKScene, ObservableObject {
    
    // MARK: - Properties
    
    private lazy var pieChartView: PieChartView = {
        let pieChartView = PieChartView()
        return pieChartView
    }()
    
    private lazy var hudLayer: HUDLayer = HUDLayer(screenSize: SCENE_SIZE)
    
    lazy var atmosphereBackground: SKSpriteNode = {
        let atmosphereBackground = SKSpriteNode(imageNamed: ATMOSPHERE_STAGE03)
        atmosphereBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        return atmosphereBackground
    }()
    
    lazy var earthImage: EarthSpriteNode = {
        let earth = EarthSpriteNode()
        return earth
    }()
    
    lazy var blackOverlay: SKSpriteNode = {
        let overlay = SKSpriteNode(color: .black, size: CGSize(width: SCENE_SIZE.width, height: SCENE_SIZE.height))
        overlay.alpha = 0.5
        overlay.position = CGPoint(x: SCENE_SIZE.width / 2, y:  SCENE_SIZE.height/2)
        overlay.name = "overlay"
        return overlay
    }()
    
    private lazy var clouds: [SKSpriteNode] = {
        let positions: [CGPoint] = [
            CGPoint(x: size.width * 0.12, y: size.height * 0.8),
            CGPoint(x: size.width * 0.0912, y: size.height * 0.5),
            CGPoint(x: size.width * 0.14, y: size.height * 0.2),
            CGPoint(x: size.width * 0.82, y: size.height * 0.8),
            CGPoint(x: size.width * 0.88, y: size.height * 0.52)
        ]
        return positions.map { createCloudTexture(at: $0) }
    }()
    
    var viewModel: GameSceneDelegate? = nil
    
    // MARK: - Lifecycle

    override func didMove(to view: SKView) {
        
        addChild(atmosphereBackground)
        addChild(earthImage)
        addChild(hudLayer)
        
        earthImage.viewModel = viewModel
        
        clouds.forEach { addChild($0) }
        
        setupPieChartView()
        
        self.backgroundColor = UIColor(named: "background") ?? .white
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateEarthImage), name: Notification.Name("EarthTextureDidChange"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateRedSquareNode), name: Notification.Name("updateCO2Node"), object: nil)

    }
    
    // MARK: - Additional Methods

    private func setupPieChartView() {
        let pieChartConvert = UIHostingController(rootView: AnyView(pieChartView))
        addHostingController(to: pieChartConvert)
        
        if let skView = self.view {
            pieChartConvert.view.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                pieChartConvert.view.centerXAnchor.constraint(equalTo: skView.centerXAnchor, constant: -12),
                pieChartConvert.view.centerYAnchor.constraint(equalTo: skView.centerYAnchor, constant: 14),
                pieChartConvert.view.widthAnchor.constraint(equalTo: skView.widthAnchor),
                pieChartConvert.view.heightAnchor.constraint(equalTo: skView.heightAnchor, multiplier: 0.3)
            ])
        }
        
        pieChartConvert.view.backgroundColor = UIColor.clear
    }
    
    
    private func addHostingController(to controller: UIHostingController<AnyView>) {
        if let skView = self.view {
            skView.addSubview(controller.view)
            controller.view.frame = skView.bounds
            controller.view.backgroundColor = UIColor.clear
        }
    }
    
    private func createCloudTexture(at position: CGPoint) -> SKSpriteNode {
        let cloudBackground = SKSpriteNode(imageNamed: DARK_CLOUD)
        cloudBackground.position = position
        cloudBackground.scale(to: autoScale(cloudBackground, widthProportion: 0.07, screenSize: SCENE_SIZE))
        return cloudBackground
    }
    
    private func updateCloudsTexture(textureName: String) {
        clouds.forEach { node in
            node.texture = SKTexture(imageNamed: textureName)
        }
    }
    
    @objc func updateEarthImage() {
        
        if let currentCO2 = viewModel?.co2Status.current,
           let initialCO2 = viewModel?.co2Status.initial,
           let goalCO2 = viewModel?.co2Status.goal {
            let co2Percentage = (currentCO2 - goalCO2) / (initialCO2 - goalCO2)
            switch co2Percentage {
            case let p where p >= 0.67:
                earthImage.texture = SKTexture(imageNamed: PLANET_STAGE03)
                atmosphereBackground.texture = SKTexture(imageNamed: ATMOSPHERE_STAGE03)
                updateCloudsTexture(textureName: DARK_CLOUD)
            case let p where p > 0 && p < 0.67:
                earthImage.texture = SKTexture(imageNamed: PLANET_STAGE02)
                atmosphereBackground.texture = SKTexture(imageNamed: ATMOSPHERE_STAGE02)
                updateCloudsTexture(textureName: HALF_DARK_CLOUD)
            case let p where p <= 0:
                earthImage.texture = SKTexture(imageNamed: PLANET_STAGE01)
                atmosphereBackground.texture = SKTexture(imageNamed: ATMOSPHERE_STAGE01)
                updateCloudsTexture(textureName: LIGHT_CLOUD)
                hudLayer.buttonNode.isHidden = false
            default:
                break
            }
        }
        
    }
    
    @objc func updateRedSquareNode() {
        
        for node in earthImage.children {
            if let redSquareNode = node as? RedSquareNode {
                redSquareNode.removeEmissionNodes()
            }
        }
    }
    
    // MARK: - Touch Handling

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        
        if let node = nodes(at: location).first {
            if node.name == "computerButton" {
                viewModel?.isComputerInterfaceVisible.toggle()
            } else if node.name == "questionButton" {
                viewModel?.isDoubt.toggle()
            } else if node.name == "restore" || node.name == "restoreText" {
                viewModel?.changeCO2Status(actions: [])
                
                let scaleUpAction = SKAction.scale(to: 1.1, duration: 0.15)
                let scaleDownAction = SKAction.scale(to: 1.0, duration: 0.15)
                let scaleSequence = SKAction.sequence([scaleUpAction, scaleDownAction])
                if node.name == "restoreText" {
                    node.parent?.run(scaleSequence){
                        node.parent?.removeAllActions()
                    }
                } else {
                    node.run(scaleSequence) {
                        node.removeAllActions()
                    }
                }
                
                hudLayer.buttonNode.isHidden = true
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("EarthTextureDidChange"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("updateCO2Node"), object: nil)
    }
}

