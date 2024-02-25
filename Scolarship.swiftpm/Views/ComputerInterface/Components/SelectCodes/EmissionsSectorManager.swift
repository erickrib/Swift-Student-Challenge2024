//
//  EmissionSectorManager.swift
//
//
//  Created by Erick Ribeiro on 25/01/24.
//

import Foundation
import SpriteKit

// MARK: - Emission Sector Manager

class EmissionSectorManager:ObservableObject {
    
    @Published var strategy: EmissionSectorStrategy
    
    init(strategy: EmissionSectorStrategy) {
        self.strategy = strategy
    }
    
    // Get the emission sector associated with the current strategy.
    func getSector() -> EmissionSectors {
        self.strategy.configuration
    }
}

// MARK: - Sector Instance

enum SectorInstance:CaseIterable {
    case industry
    case energy
    case transport
    case agriculture
    case deforestation
    
    private static var instances: [SectorInstance: EmissionSectorStrategy] = [:]
    
    // Get a singleton instance of the emission sector strategy associated with this case.
    func getInstance() -> EmissionSectorStrategy {
        if let existingInstance = SectorInstance.instances[self] {
            return existingInstance
        } else {
            let newStrategy = createInstance()
            SectorInstance.instances[self] = newStrategy
            return newStrategy
        }
    }
    
    // Create a new instance of the emission sector strategy associated with this case.
    private func createInstance() -> EmissionSectorStrategy {
        switch self {
        case .industry:
            return IndustrySector()
        case .energy:
            return EnergySector()
        case .transport:
            return TransportSector()
        case .deforestation:
            return DeforestationSector()
        case .agriculture:
            return AgricultureSector()
        }
    }
    
    // Get all singleton instances of emission sector strategies.
    static func getAllInstances() -> [EmissionSectorStrategy] {
        return instances.values.map { $0 }
    }
}
