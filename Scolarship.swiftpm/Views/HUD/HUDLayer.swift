//
//  File.swift
//  
//
//  Created by Erick Ribeiro on 21/01/24.
//

import SpriteKit

class HUDLayer: SKNode {
    
    weak var delegate: ModalPresenter?

    init(screenSize: CGSize) {
        super.init()

        createComputerButton(size: screenSize)
        createGoalCO2Rectangle(size: screenSize)
        createQuestionButton(size: screenSize)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Elements Create

    private func createComputerButton(size: CGSize) {
        let computerButton = SKSpriteNode(imageNamed: "computer")
        computerButton.position = CGPoint(x: size.width * 0.88, y: size.height * 0.13)
        computerButton.name = "computerButton"
        computerButton.scale(to: autoScale(computerButton, widthProportion: 0.10, screenSize: SCENE_SIZE))

//        let scaleUp = SKAction.scale(to: 1.2, duration: 1.0)
//        let scaleDown = SKAction.scale(to: 1.0, duration: 1.0)
//        let pulsate = SKAction.sequence([scaleUp, scaleDown])
//        let repeatPulsate = SKAction.repeatForever(pulsate)
//
//        computerButton.run(repeatPulsate)

        addChild(computerButton)
    }


    private func createGoalCO2Rectangle(size: CGSize) {
        
        let rectangleNode = SKNode()

        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width * 0.15, height: 41), cornerRadius: 10)
        rectangle.fillColor = .purple
        rectangleNode.position = CGPoint(x: size.width * 0.2, y: size.height - 70)


        let goalLabel = SKLabelNode(text: "Goal:")
        goalLabel.fontSize = 18
        goalLabel.fontColor = .white
        goalLabel.fontName = UIFont.boldSystemFont(ofSize: 16.0).fontName
        goalLabel.position = CGPoint(x: rectangle.frame.width / 5, y: 15)

        rectangleNode.addChild(rectangle)
        rectangleNode.addChild(goalLabel)

        let co2ValueLabel = SKLabelNode(text: "350")
        co2ValueLabel.fontSize = 18
        co2ValueLabel.fontColor = .white
        co2ValueLabel.fontName = UIFont.boldSystemFont(ofSize: 16.0).fontName
        co2ValueLabel.position = CGPoint(x: rectangle.frame.width * 0.6, y: 13)


        let co2TextLabel = SKLabelNode(text: "CO\u{2082}")
        co2TextLabel.fontSize = 18
        co2TextLabel.fontColor = .white
        co2TextLabel.fontName = UIFont.boldSystemFont(ofSize: 16.0).fontName
        co2TextLabel.position = CGPoint(x: rectangle.frame.width * 0.8, y: 13)

        rectangleNode.addChild(co2ValueLabel)
        rectangleNode.addChild(co2TextLabel)
        
        addChild(rectangleNode)

    }

    private func createQuestionButton(size: CGSize) {
        let questionButton = SKSpriteNode(imageNamed: "doubt")
        questionButton.position = CGPoint(x: SCENE_SIZE.width * 0.06, y: SCENE_SIZE.height - 50)
        questionButton.name = "questionButton"
        questionButton.isUserInteractionEnabled = true

        let questionMarkLabel = SKLabelNode(text: "?")
        questionMarkLabel.fontSize = 24
        questionMarkLabel.fontColor = .black
        questionMarkLabel.fontName = UIFont.boldSystemFont(ofSize: 16.0).fontName
        questionMarkLabel.position = CGPoint(x: 0, y: -9)

        questionButton.addChild(questionMarkLabel)
        addChild(questionButton)
    }
}
