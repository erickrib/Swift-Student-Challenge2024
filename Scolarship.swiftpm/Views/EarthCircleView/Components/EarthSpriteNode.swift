//
//  File.swift
//
//
//  Created by Erick Ribeiro on 31/01/24.
//

import SpriteKit

class EarthSpriteNode: SKSpriteNode {
    
    var viewModel: GameSceneDelegate?
    
    init() {
        let texture = SKTexture(imageNamed: PLANET)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = CGPoint(x: SCENE_SIZE.width / 2, y: SCENE_SIZE.height / 2)
        self.scale(to: autoScale(self, widthProportion: 0.6525, screenSize: SCENE_SIZE))
        
        let positionsRedSquareS: [(CGPoint, CGFloat)] = [
            (CGPoint(x: -size.width * 0.42, y: size.height * 0.15), 60),
            (CGPoint(x: -size.width * 0.28, y: size.height * 0.32), 40),
            (CGPoint(x: -size.width * 0.05, y: size.height * 0.4), 0),
            (CGPoint(x: size.width * 0.16, y: size.height * 0.37), -35),
            (CGPoint(x: size.width * 0.35, y: size.height * 0.18), -60),
        ]
        
        let positionsBlueSquare: [CGPoint] = [
            CGPoint(x: -size.width * 0.28, y: -size.height * 0.22),
            CGPoint(x: size.width * 0.24, y: -size.height * 0.22)
        ]
        
        let sectors = SectorInstance.allCases
        
        for (index, (position, rotation)) in positionsRedSquareS.enumerated() {
            let redSquareSize = CGSize(width: 50, height: 50)
            let redSquareNode = RedSquareNode(size: redSquareSize, rotation: rotation.degreesToRadians)
            redSquareNode.earthSpriteNode = self
            redSquareNode.position = position
            redSquareNode.sector = sectors[index].getInstance()
            redSquareNode.configureEmissionNodes()
            redSquareNode.emitBlueBalls()
            
            addChild(redSquareNode)

        }
        
        let absorbs:[EmissionSectorStrategy] = [OceanAbsorb(), ForestsAbsorb()]
        
        for (index, position) in positionsBlueSquare.enumerated() {
            let blueSquareSize = CGSize(width: 250, height: 50)
            let rotation: CGFloat = index > 0 ? -CGFloat.pi / 1.3 : CGFloat.pi / 1.3
            
            let blue = BlueSquareNode(size: blueSquareSize, rotation: rotation)
            blue.position = position
            blue.earthSpriteNode = self
            blue.sector = absorbs[index]
            addChild(blue)
            blue.emitBlueBalls()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func openDetailsSector(chosenSector: EmissionSectorStrategy){
        viewModel?.isSectorDetails = true
        viewModel?.chosenSector = chosenSector
    }
}


class RedSquareNode: SKSpriteNode {
    
    var earthSpriteNode: EarthSpriteNode?
    var emissionNodes: [SKShapeNode] = []
    var sector: EmissionSectorStrategy?
    
    init(size: CGSize, rotation: CGFloat) {
        super.init(texture: nil, color: .clear, size: size)
        isUserInteractionEnabled  = true
        zRotation = rotation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureEmissionNodes() {
        for i in 0..<(sector?.configuration.currentCO2Nodes ?? 0) {
            let emissionNode = createEmissionNode(at: i)
            addChild(emissionNode)
            emissionNodes.append(emissionNode)
        }
    }
    
    private func createEmissionNode(at index: Int) -> SKShapeNode {
        let emissionNode = SKShapeNode(circleOfRadius: 3)
        emissionNode.fillColor = .blue
        emissionNode.alpha = 0.0
        
        return emissionNode
    }
    
    func removeEmissionNodes() {
        for emissionNode in emissionNodes {
            emissionNode.removeFromParent()
        }
        emissionNodes.removeAll()
        configureEmissionNodes()
        emitBlueBalls()
        
        print("\(sector?.configuration.name) : \(sector?.configuration.currentCO2Nodes)")
    }
    
    func emitBlueBalls() {
        for (index, emissionNode) in emissionNodes.enumerated() {
            let orderedIndex = generateRandomIndices(count: emissionNodes.count)[index]
            
            let percentage = CGFloat(orderedIndex) / CGFloat(9)
            let xPosition = -50 + percentage * 100
            
            let moveUpAction = SKAction.moveBy(x: xPosition, y: 60, duration: 5.0)
            let timer = mapToRange(sector?.configuration.currentCO2Nodes ?? 0)
            let waitAction = SKAction.wait(forDuration: 1.0 + Double(index) + timer)
            
            let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
            
            let sequenceAction = SKAction.sequence([waitAction, fadeInAction, moveUpAction, fadeOutAction])
            
            let resetAction = SKAction.run {
                emissionNode.position = CGPoint(x: 0, y: 0)
                emissionNode.alpha = 0.0
            }
            
            let fullSequenceAction = SKAction.sequence([sequenceAction, resetAction])
            
            let repeatForeverAction = SKAction.repeatForever(fullSequenceAction)
            
            emissionNode.run(repeatForeverAction)
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let sector = self.sector {
            earthSpriteNode?.openDetailsSector(chosenSector: sector)
        }
    }
    
    private func mapToRange(_ value: Int) -> Double {
        switch value {
        case 0...4:
            return 2.0
        case 5...8:
            return 1.0
        case 9...12:
            return -1.0
        case 13...16:
            return -3.0
        default:
            return 0.0
        }
    }
    
    private func generateRandomIndices(count: Int) -> [Int] {
        guard count > 0 else {
            return []
        }

        var indices = Array(0..<count)
        indices.shuffle()

        return indices
    }
}

class BlueSquareNode: SKSpriteNode {
    
    var emissionNodes: [SKShapeNode] = []
    var initialPositions: [CGPoint] = []
    
    var earthSpriteNode: EarthSpriteNode?
    var sector: EmissionSectorStrategy?
    
    init(size: CGSize, rotation: CGFloat) {
        super.init(texture: nil, color: .clear, size: size)
        isUserInteractionEnabled  = true
        configureEmissionNodes()
        
        zRotation = rotation
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureEmissionNodes() {
        for i in 0..<10 {
            let emissionNode = createEmissionNode(at: i)
            emissionNode.alpha = 0.0
            addChild(emissionNode)
            emissionNodes.append(emissionNode)
            initialPositions.append(emissionNode.position)
        }
    }
    
    func createEmissionNode(at index: Int) -> SKShapeNode {
        let emissionNode = SKShapeNode(circleOfRadius: 3)
        emissionNode.fillColor = .blue
        
        let radius: CGFloat = 200
        let centerX: CGFloat = -size.width * 0.1
        let centerY: CGFloat = -size.height * 1.5
        
        let startAngle = CGFloat.pi / 3
        let angle = startAngle + CGFloat(index) / CGFloat(9) * CGFloat.pi / 3
        
        let xPosition = centerX + radius * cos(angle)
        let yPosition = centerY + radius * sin(angle)
        
        emissionNode.position = CGPoint(x: xPosition, y: yPosition)
        
        return emissionNode
    }
    
    func emitBlueBalls() {
        for (index, emissionNode) in emissionNodes.enumerated() {
            let moveUpAction = SKAction.moveBy(x: 0, y: -self.size.height * 2, duration: 5.0)
            let waitAction = SKAction.wait(forDuration: 1.0 + Double(index))
            
            let fadeInAction = SKAction.fadeIn(withDuration: 0.5)
            let fadeOutAction = SKAction.fadeOut(withDuration: 0.5)
            
            let sequenceAction = SKAction.sequence([waitAction, fadeInAction, moveUpAction, fadeOutAction])
            
            let resetAction = SKAction.run {
                emissionNode.position = self.initialPositions[index]
                emissionNode.alpha = 0.0
            }
            
            let fullSequenceAction = SKAction.sequence([sequenceAction, resetAction])
            
            let repeatForeverAction = SKAction.repeatForever(fullSequenceAction)
            
            emissionNode.run(repeatForeverAction)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let sector = self.sector {
            earthSpriteNode?.openDetailsSector(chosenSector: sector)
        }
    }
}
