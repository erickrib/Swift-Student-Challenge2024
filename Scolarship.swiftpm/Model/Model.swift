//
//  File.swift
//  
//
//  Created by Erick Ribeiro on 24/01/24.
//

import Foundation
import SpriteKit

struct CO2Status: Equatable {
    var current: Double = 421
    var initial: Double = 421
    var goal: Double = 350
}

struct EmissionSectors:Identifiable {
    var id: UUID = UUID()
    
    var name:String
    var iconName:String
    var colorName:String
    
    var percentageEmission: Double
    var absorption: Double
    var reductionTarget: Double?
    var sustainableActionFunction: [SustainableActionFunction]
}

struct SustainableActionFunction:Identifiable, Equatable {
    var id: UUID = UUID()

    var code: String
    var description: String
    var co2ReductionValue: Double
    var costEcoPoints:Int
}
