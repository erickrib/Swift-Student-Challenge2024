//
//  File.swift
//  
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SwiftUI
import SpriteKit

class EarthCircleViewModel: ObservableObject {
    let scene:SKScene = GameScene()
    
    func getScene(size: CGSize) -> SKScene {
        scene.size = size
        return scene
    }
}
