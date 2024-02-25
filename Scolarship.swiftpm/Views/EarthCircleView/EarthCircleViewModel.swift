//
//  EarthCircleViewModel.swift
//
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SwiftUI
import SpriteKit

protocol GameSceneDelegate {
    var isComputerInterfaceVisible: Bool { get set }
    var isSectorDetails:Bool { get set }
    var isDoubt:Bool { get set }
    var co2Status:CO2Status { get set }
    var chosenSector:EmissionSectorStrategy? { get set }
    func changeCO2Status(actions: [SustainableActionFunction])
}

class EarthCircleViewModel: ObservableObject, GameSceneDelegate {
    
    @Published var isComputerInterfaceVisible:Bool = false
    @Published var isExecutionResult:Bool = false
    @Published var isSectorDetails = false
    @Published var isDoubt = true
    
    @Published var co2Status:CO2Status = CO2Status()
    @Published var messages: [Message] = []
    
    @Published var chosenSector:EmissionSectorStrategy?
    
    var scene:GameScene?
    
    // Return game scene
    func getScene(size: CGSize) -> SKScene {
        let scene = GameScene(size: size)
        scene.viewModel = self
        self.scene = scene
        return scene
    }
    
    // Changes scene co2
    func changeCO2Status(actions: [SustainableActionFunction]){
        var co2Difference = co2Status.initial - co2Status.goal
        let allInstances = SectorInstance.getAllInstances()
        
        for var sector in allInstances {
            sector.configuration.reductionTarget = co2Difference * sector.configuration.percentageEmission
            sector.configuration.currentCO2Nodes = sector.configuration.initialCO2Nodes
        }
                
        for code in actions{
            if var sectorInstance = allInstances.first(where: { $0.configuration.sustainableActionFunction.contains { $0.id == code.id }}) {
                if let reductionTarget = sectorInstance.configuration.reductionTarget {
                    sectorInstance.configuration.reductionTarget = max(0, reductionTarget - (code.co2ReductionValue + (code.co2ReductionValue * code.bonus)))
                    co2Difference = (co2Difference - reductionTarget) + (sectorInstance.configuration.reductionTarget ?? 0)
                    
                }
                
                co2Status.current = co2Status.initial
                isExecutionResult = true
                isComputerInterfaceVisible = false
            }
        }
                
        co2Status.current = co2Status.goal + min(71, co2Difference)
        
        messages = []

        for sector in SectorInstance.allCases {
            
            var instance = sector.getInstance()
            
            updateMessages(instance)
            
            if instance.configuration.reductionTarget == 0{
                instance.configuration.currentCO2Nodes = (instance.configuration.currentCO2Nodes )/2                
            }
        }
        
        updateEarthTexture()
        updateCO2Node()
    }
    
    // Update execution messages
    func updateMessages(_ sector: EmissionSectorStrategy) {
        if sector.configuration.reductionTarget == 0 {
            messages.append(Message(successMessage: "Successfully reduced CO\u{2082} emissions in \(sector.configuration.name).", isSuccess:  true))
            
        } else {
            messages.append(Message(errorMessage: "Failed to reduce CO\u{2082} emissions in \(sector.configuration.name). You still need to reduce emissions by \(sector.configuration.reductionTarget?.formattedDoubleString() ?? "") in this sector.", isSuccess: false))
        }
    }
    
    private func updateEarthTexture() {
        NotificationCenter.default.post(name: Notification.Name("EarthTextureDidChange"), object: nil)
    }
    
    private func updateCO2Node() {
        NotificationCenter.default.post(name: Notification.Name("updateCO2Node"), object: nil)
    }
}
