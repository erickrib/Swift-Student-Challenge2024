//
//  File.swift
//
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SwiftUI
import SpriteKit

protocol GameSceneDelegate {
    var isComputerInterfaceVisible: Bool { get set }
    var co2Status:CO2Status { get set }
}

class EarthCircleViewModel: ObservableObject, GameSceneDelegate {
    
    @Published var isComputerInterfaceVisible:Bool = false
    @Published var isExecutionResult:Bool = false
    
    @Published var co2Status:CO2Status = CO2Status()
    @Published var messages: [Message] = []
    
    var scene:GameScene?
    
    func getScene(size: CGSize) -> SKScene {
        let scene = GameScene(size: size)
        scene.viewModel = self
        self.scene = scene
        return scene
    }
    
    func changeCO2Status(actions: [SustainableActionFunction]){
        var co2Difference = co2Status.initial - co2Status.goal
        let allInstances = SectorInstance.getAllInstances()
        
        for var sector in allInstances {
            sector.configuration.reductionTarget = co2Difference * sector.configuration.percentageEmission
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
        for sector in SectorInstance.allCases {
            updateMessages(sector.getInstance())
        }
        updateEarthTexture()        
    }
    
    func updateMessages(_ sector: any EmissionSectorStrategy) {
        
        if sector.configuration.reductionTarget == 0 {
            messages.append(Message(successMessage: "Redução de CO2 alcançada com sucesso em \(sector.configuration.name)", isSuccess:  true))
        } else {
            messages.append(Message(errorMessage: "Falha na redução de CO2 em \(sector.configuration.name)", isSuccess: false))
        }
        
    }
    
    private func updateEarthTexture() {
        NotificationCenter.default.post(name: Notification.Name("EarthTextureDidChange"), object: nil)
    }
    
}
