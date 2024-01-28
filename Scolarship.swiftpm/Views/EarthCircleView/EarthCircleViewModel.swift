//
//  File.swift
//  
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SwiftUI
import SpriteKit

class EarthCircleViewModel: ObservableObject {
    
    @Published var isComputerInterfaceVisible = false
    @Published var isExecutionResult = false

    @Published var co2Status = CO2Status()
    
    var scene:GameScene?
    
    func getScene(size: CGSize) -> SKScene {
        scene = GameScene(size: size, viewModel: self)
        return scene ?? SKScene()
    }
    
    func changeCO2Status(value: Double){
        co2Status.current = co2Status.initial - value
        isExecutionResult = true
        isComputerInterfaceVisible = false
    }
}
