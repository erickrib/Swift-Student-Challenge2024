//
//  File.swift
//  
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SwiftUI
import SpriteKit

class EarthCircleViewModel: ObservableObject {
    let scene:GameScene = GameScene()
    
    @Published var isComputerInterfaceVisible = false
    @Published var isExecutionResult = false

    
    func getScene(size: CGSize) -> SKScene {
        scene.size = size
        scene.viewModel = self
        return scene
    }
}
