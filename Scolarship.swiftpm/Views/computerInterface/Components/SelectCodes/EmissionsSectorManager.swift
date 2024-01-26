//
//  File.swift
//
//
//  Created by Erick Ribeiro on 25/01/24.
//

import Foundation
import SpriteKit

class EmissionSectorManager:ObservableObject {
    
    @Published var strategy: EmissionSectorStrategy
    
    init(strategy: EmissionSectorStrategy) {
        self.strategy = strategy
    }
    
    func getSector() -> [EmissionSectors] {
        self.strategy.configure()
    }
    
}
