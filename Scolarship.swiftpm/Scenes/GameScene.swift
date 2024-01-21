//
//  File.swift
//
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SpriteKit
import SwiftUI

class GameScene: SKScene {
    
    var atmosphereBackground: SKSpriteNode {
        let atmosphereBackground = SKSpriteNode(imageNamed: "atmosphere")
        atmosphereBackground.position = CGPoint(x: size.width/2, y: size.height/2)
        return atmosphereBackground
    }
    
    private lazy var pieChartView: PieChartView = {
        let pieChartView = PieChartView()
        return pieChartView
    }()
    
    private lazy var hudLayer: HUDLayer = HUDLayer(screenSize: SCENE_SIZE)
    
    lazy var earthImage: SKSpriteNode = {
        let texture = SKTexture(imageNamed: PLANET)
        let image = SKSpriteNode(texture:  texture)
        image.position = CGPoint(x: SCENE_SIZE.width / 2, y:  SCENE_SIZE.height/2)
        image.scale(to: autoScale(image, widthProportion: 0.6525, screenSize: SCENE_SIZE))
        return image
    }()
    
    @State private var isComputerInterfaceVisible = false
    
    override func didMove(to view: SKView) {
        
        addChild(atmosphereBackground)
        addChild(earthImage)
        addChild(hudLayer)
        
        let cloud1 = createCloudBackground(at: CGPoint(x: size.width * 0.12, y: size.height * 0.8))
        let cloud2 = createCloudBackground(at: CGPoint(x: size.width * 0.0912, y: size.height * 0.5))
        let cloud3 = createCloudBackground(at: CGPoint(x: size.width * 0.14, y: size.height * 0.2))
        let cloud4 = createCloudBackground(at: CGPoint(x: size.width * 0.82, y: size.height * 0.8))
        let cloud5 = createCloudBackground(at: CGPoint(x: size.width * 0.88, y: size.height * 0.52))
        
        addChild(cloud1)
        addChild(cloud2)
        addChild(cloud3)
        addChild(cloud4)
        addChild(cloud5)
        
        setupPieChartView()
        
        self.backgroundColor = .white
    }
    
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
    
    private func createCloudBackground(at position: CGPoint) -> SKSpriteNode {
        let cloudBackground = SKSpriteNode(imageNamed: "cloud")
        cloudBackground.position = position
        cloudBackground.scale(to: autoScale(cloudBackground, widthProportion: 0.07, screenSize: SCENE_SIZE))
        return cloudBackground
    }
    
    private func showCustomModal() {
        isComputerInterfaceVisible.toggle()
    }
    
    func setupModal() {
        let modalView = ComputerInterface()
        
        let modalController = UIHostingController(rootView: modalView)
        modalController.view.translatesAutoresizingMaskIntoConstraints = false
        
        if let skView = self.view {
            skView.addSubview(modalController.view)
            
            NSLayoutConstraint.activate([
                modalController.view.centerXAnchor.constraint(equalTo: skView.centerXAnchor),
                modalController.view.centerYAnchor.constraint(equalTo: skView.centerYAnchor),
                modalController.view.widthAnchor.constraint(equalTo: skView.widthAnchor, multiplier: 0.95),
                modalController.view.heightAnchor.constraint(equalTo: skView.heightAnchor, multiplier: 0.8)
            ])
            
            modalController.view.isHidden = !isComputerInterfaceVisible
        }
    }
}

