//
//  File.swift
//
//
//  Created by Erick Ribeiro on 21/01/24.
//

import SpriteKit
import SwiftUI

class HUDLayer: SKNode {
    
    weak var delegate: ModalPresenter?
    
    init(screenSize: CGSize) {
        super.init()
        
        createComputerButton(size: screenSize)
        createGoalCO2Rectangle(size: screenSize)
        createQuestionButton(size: screenSize)
        createPulsatingWaves(size: screenSize)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Elements Create
    
    private func createComputerButton(size: CGSize) {
        let computerButton = SKSpriteNode(imageNamed: COMPUTER_BUTTON)
        computerButton.position = CGPoint(x: size.width * 0.88, y: size.height * 0.13)
        computerButton.name = "computerButton"
        computerButton.zPosition = 99
        computerButton.scale(to: autoScale(computerButton, widthProportion: 0.10, screenSize: SCENE_SIZE))
        
        let scaleUp = SKAction.scale(to: 1.0, duration: 1.0)
        let scaleDown = SKAction.scale(to: 0.9, duration: 1.0)
        let pulsate = SKAction.sequence([scaleUp, scaleDown])
        let repeatPulsate = SKAction.repeatForever(pulsate)
        
        computerButton.run(repeatPulsate)
        
        addChild(computerButton)
    }
    
    
    private func createGoalCO2Rectangle(size: CGSize) {
        
        let rectangleNode = SKNode()
        
        let rectangle = SKShapeNode(rect: CGRect(x: 0, y: 0, width: size.width * 0.12, height: 41), cornerRadius: 10)
        rectangle.fillColor = UIColor(named: "goal") ?? .purple
        rectangleNode.position = CGPoint(x: SCENE_SIZE.width * 0.08, y: SCENE_SIZE.height * 0.9)
        
        let goalLabel = SKLabelNode(attributedText: attributedText(string: "Goal:", size: 16, weight: .medium))
        goalLabel.position = CGPoint(x: rectangle.frame.width / 5, y: 15)
        
        rectangleNode.addChild(rectangle)
        rectangleNode.addChild(goalLabel)
        
        let co2ValueLabel = SKLabelNode(attributedText: attributedText(string: "350", size: 16, weight: .medium))
        co2ValueLabel.position = CGPoint(x: rectangle.frame.width * 0.6, y: 15)
        
        let co2TextLabel = SKLabelNode(attributedText: attributedText(string: "CO\u{2082}", size: 16, weight: .medium))
        co2TextLabel.position = CGPoint(x: rectangle.frame.width * 0.8, y: 15)
        
        rectangleNode.addChild(co2ValueLabel)
        rectangleNode.addChild(co2TextLabel)
        
        addChild(rectangleNode)
        
    }
    
    private func createQuestionButton(size: CGSize) {
        let questionButton = SKSpriteNode(imageNamed: "doubt")
        questionButton.position = CGPoint(x: SCENE_SIZE.width * 0.93, y: SCENE_SIZE.height * 0.91)
        questionButton.name = "questionButton"
        questionButton.isUserInteractionEnabled = true
        
        let questionMarkLabel = SKLabelNode(text: "?")
        questionMarkLabel.fontSize = 24
        questionMarkLabel.fontColor = .white
        questionMarkLabel.fontName = UIFont.boldSystemFont(ofSize: 16.0).fontName
        questionMarkLabel.position = CGPoint(x: 0, y: -7)
        
        questionButton.addChild(questionMarkLabel)
        addChild(questionButton)
    }
    
    private func attributedText(string: String, size: CGFloat, weight: UIFont.Weight) -> NSAttributedString {
        let attributedText = NSAttributedString(
            string: string,
            attributes: [
                .font: UIFont.systemFont(ofSize: size, weight: weight),
                .foregroundColor: UIColor.white
            ]
        )
        
        return attributedText
    }
    
    func createPulsatingWaves(size: CGSize) {
        // Criar múltiplos nós para as ondas pulsantes
        for i in 0..<3 {
            let delay = Double(i) * 0.2 // Atraso entre cada onda
            let pulseDuration = 1.5 // Duração da pulsação
            
            let waveNode = SKShapeNode(circleOfRadius: 50)
            waveNode.fillColor = UIColor(named: "pulseAnimation") ?? .gray
            waveNode.position = CGPoint(x: size.width * 0.88, y: size.height * 0.13)
            addChild(waveNode)
            
            // Configurar a escala inicial e final para criar a pulsação
            let scaleOutAction = SKAction.scale(to: 2.0, duration: pulseDuration)
            let fadeOutAction = SKAction.fadeOut(withDuration: pulseDuration)
            let groupOutAction = SKAction.group([scaleOutAction, fadeOutAction])
            
            let scaleInAction = SKAction.scale(to: 1.0, duration: 0)
            let fadeInAction = SKAction.fadeIn(withDuration: 0)
            let groupInAction = SKAction.group([scaleInAction, fadeInAction])
            
            // Sequência de ações para cada onda
            let pulseSequence = SKAction.sequence([
                SKAction.wait(forDuration: delay),
                groupOutAction,
                SKAction.run {
                    waveNode.isHidden = true // Ocultar o nó temporariamente
                },
                SKAction.wait(forDuration: 1), // Tempo de espera antes de mostrar o nó novamente
                SKAction.run {
                    waveNode.isHidden = false // Mostrar o nó novamente
                },
                groupInAction
            ])
            
            // Executar a sequência de pulsação
            waveNode.run(SKAction.repeatForever(pulseSequence))
        }
    }

}
