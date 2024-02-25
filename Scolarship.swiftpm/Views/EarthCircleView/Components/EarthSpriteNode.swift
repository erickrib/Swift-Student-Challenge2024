//
//  EarthSpriteNode.swift
//
//
//  Created by Erick Ribeiro on 31/01/24.
//

import SpriteKit

class EarthSpriteNode: SKSpriteNode {
    
    var viewModel: GameSceneDelegate?
    
    init() {
        let texture = SKTexture(imageNamed: PLANET_STAGE03)
        super.init(texture: texture, color: .clear, size: texture.size())
        self.position = CGPoint(x: SCENE_SIZE.width / 2, y: SCENE_SIZE.height / 2)
        self.scale(to: autoScale(self, widthProportion: 0.6525, screenSize: SCENE_SIZE))
        
        // Position emission node group
        var positionsRedSquareS: [(CGPoint, CGFloat)] = [
            (CGPoint(x: -size.width * 0.35, y: size.height * 0.12), 60),
            (CGPoint(x: -size.width * 0.25, y: size.height * 0.25), 40),
            (CGPoint(x: -size.width * 0.03, y: size.height * 0.33), 0),
            (CGPoint(x: size.width * 0.191, y: size.height * 0.26), -35),
            (CGPoint(x: size.width * 0.31, y: size.height * 0.11), -65),
        ]
        
        // Position absorption node group
        var positionsBlueSquare: [CGPoint] = [
            CGPoint(x: -size.width * 0.28, y: -size.height * 0.22),
            CGPoint(x: size.width * 0.24, y: -size.height * 0.22)
        ]
        
        // Group of modified position nodes
        var modifiedPositionsRedSquareS: [(CGPoint, CGFloat)] = []
        var modifiedPositionsBlueSquareS: [CGPoint] = []

        if SCENE_SIZE.width > 1300 {
            for position in positionsRedSquareS {
                let modifiedPosition: (CGPoint, CGFloat)
            
                modifiedPosition = (CGPoint(x: position.0.x * 0.9, y: position.0.y * 0.9), position.1)
                
                modifiedPositionsRedSquareS.append(modifiedPosition)
            }
            
            for position in positionsBlueSquare {
                let modifiedPosition: CGPoint
            
                modifiedPosition = CGPoint(x: position.x * 0.9, y: position.y * 0.9)
                
                modifiedPositionsBlueSquareS.append(modifiedPosition)
            }
            
            positionsRedSquareS = modifiedPositionsRedSquareS
            positionsBlueSquare = modifiedPositionsBlueSquareS

        }
        
        // Creation of co2 emission animation
        let sectors = SectorInstance.allCases
        for (index, (position, rotation)) in positionsRedSquareS.enumerated() {
            let redSquareSize = CGSize(width: size.width * 0.128, height: size.height * 0.108)
            let redSquareNode = RedSquareNode(size: redSquareSize, rotation: rotation.degreesToRadians)
            redSquareNode.earthSpriteNode = self
            redSquareNode.position = position
            redSquareNode.sector = sectors[index].getInstance()
            redSquareNode.configureEmissionNodes()
            redSquareNode.emitBlueBalls()
            
            addChild(redSquareNode)

        }
        
        // Creation of co2 absorption animation
        let absorbs:[EmissionSectorStrategy] = [OceanAbsorb(), ForestsAbsorb()]
        for (index, position) in positionsBlueSquare.enumerated() {
            let blueSquareSize = CGSize(width: 250, height: 50)
            let rotation: CGFloat = index > 0 ? -CGFloat.pi / 1.4 : CGFloat.pi / 1.3
            
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
    
    // open modal sector details
    func openDetailsSector(chosenSector: EmissionSectorStrategy){
        viewModel?.chosenSector = chosenSector
        viewModel?.isSectorDetails = true
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
            emissionNode.position.y = self.size.height * 0.5
            addChild(emissionNode)
            emissionNodes.append(emissionNode)
        }
    }
    
    private func createEmissionNode(at index: Int) -> SKShapeNode {
        let emissionNode = SKShapeNode(circleOfRadius: 3)
        emissionNode.fillColor = UIColor(named: "carbon") ?? .orange
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
    }
    
    // CO2 emission animation
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
                emissionNode.position = CGPoint(x: 0, y: self.size.height * 0.5)
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
        emissionNode.fillColor = UIColor(named: "carbon") ?? .orange
        
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
    
    // co2 absorption animation
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
}
