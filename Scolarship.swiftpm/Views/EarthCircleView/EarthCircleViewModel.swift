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
    @Published var message = ""
    
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
            if var sectorInstance = allInstances.first(where: { $0.configuration.sustainableActionFunction.contains(code) }) {
                if let reductionTarget = sectorInstance.configuration.reductionTarget {
                    sectorInstance.configuration.reductionTarget = max(0, reductionTarget - code.co2ReductionValue)
                    co2Difference = (co2Difference - reductionTarget) + (sectorInstance.configuration.reductionTarget ?? 0)
                }
                
                co2Status.current = co2Status.initial
                isExecutionResult = true
                isComputerInterfaceVisible = false
            }
        }
        co2Status.current = co2Status.goal + min(71, co2Difference)
        message = "Olá mundo"
        
        updateEarthTexture()
    }
    
    func updateEarthTexture() {
        NotificationCenter.default.post(name: Notification.Name("EarthTextureDidChange"), object: nil)
    }
    
}
