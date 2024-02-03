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
    
    func getSector() -> EmissionSectors {
        self.strategy.configuration
    }
}

enum SectorInstance:CaseIterable {
    case industry
    case energy
    case deforestation
    case transport
    case agriculture
    
    private static var instances: [SectorInstance: EmissionSectorStrategy] = [:]
    
    func getInstance() -> any EmissionSectorStrategy {
        if let existingInstance = SectorInstance.instances[self] {
            return existingInstance
        } else {
            let newStrategy = createInstance()
            SectorInstance.instances[self] = newStrategy
            return newStrategy
        }
    }
    
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
    
    static func getAllInstances() -> [EmissionSectorStrategy] {
        return instances.values.map { $0 }
    }
}
