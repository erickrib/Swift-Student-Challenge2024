//
//  File.swift
//  
//
//  Created by Erick Ribeiro on 24/01/24.
//

import Foundation
import SpriteKit

struct CO2Status {
    var current: Double = 421
    var initial: Double = 421
    var goal: Double = 350
}

struct EmissionSectors {
    var id: UUID = UUID()
    
    var name:String
    var iconName:String
    var colorName:String
    
    var emissions: Double
    var absorption: Double
    var sustainableActionFunction: [SustainableActionFunction]
}

struct SustainableActionFunction {
    var code: String
    var description: String
    var co2ReductionValue: Double
    var costEcoPoints:Int
}
