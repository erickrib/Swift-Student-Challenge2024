//
//  File.swift
//
//
//  Created by Erick Ribeiro on 24/01/24.
//

import Foundation
import SpriteKit

protocol EmissionSectorStrategy: Identifiable {
    var configuration: EmissionSectors { get set }
}

class IndustrySector: EmissionSectorStrategy {
    
    var configuration: EmissionSectors =
    EmissionSectors(name: "Industry", iconName: "industry", colorName: "", percentageEmission: 0.25, sustainableActionFunction: [
        SustainableActionFunction(code: "increaseCleanEnergy()", description: "Transition to the use of renewable energy in industrial operations, such as solar, wind, and other renewable sources.", co2ReductionValue: 10, costEcoPoints: 10),
        SustainableActionFunction(code: "energyEfficiency()", description: "To implement more energy-efficient technologies and optimize energy consumption in all stages of production.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "useRecycledMaterials()", description: "Promote the use of recycled materials in industrial production, as they often have lower carbon emissions compared to primary source materials.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "optimizeLowEmissionTransportation()", description: "Prioritize industrial transportation methods with lower emissions such as railway, maritime, and electric vehicles.", co2ReductionValue: 10, costEcoPoints: 10),
        SustainableActionFunction(code: "investInNatureProjects()", description: "Prioritize industrial transportation methods with lower emissions such as railway, maritime, and electric vehicles.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "establishEnvironmentalGoals()", description: "Set goals aligned with your sustainability objectives, enabling an approach tailored to your specific circumstances.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "useSustainableSuppliers()", description: "Collaborate with suppliers who adopt sustainable practices, ensuring a greener supply chain.", co2ReductionValue: 10, costEcoPoints: 2)
    ])
}

class EnergySector: EmissionSectorStrategy {

    var configuration: EmissionSectors =
    EmissionSectors(name: "Energy", iconName: "energy", colorName: "", percentageEmission: 0.35, sustainableActionFunction: [
        SustainableActionFunction(code: "reduceThermalPowerPlants()", description: "Reduce dependence on thermoelectric power plants, especially coal-fired ones, lowering pollutant emissions.", co2ReductionValue: 10, costEcoPoints: 10),
        SustainableActionFunction(code: "expandWindFarms()", description: "Expand the infrastructure for harnessing kinetic wind energy, promoting a clean and renewable source.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "investInSolarEnergy()", description: "Allocate resources to solar energy projects to increase generation capacity from sunlight, an endless and environmentally friendly source.", co2ReductionValue: 10, costEcoPoints: 10),
        SustainableActionFunction(code: "investInEnergyStorageProjects()", description: "Invest in energy storage methods to ensure a constant and stable supply, particularly during periods of low generation.", co2ReductionValue: 10, costEcoPoints: 10),
        SustainableActionFunction(code: "expandHydropowerPlants()", description: "Expand hydroelectric plants that harness the conversion of the potential energy of water into electricity, while considering potential negative environmental impacts, particularly alterations to river ecosystems.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "expandNuclearPlants()", description: "Nuclear energy has the potential to reduce carbon emissions but also raises significant concerns regarding nuclear waste, costs, and complexity.", co2ReductionValue: 10, costEcoPoints: 2)
    ])
}

class TransportSector: EmissionSectorStrategy {
    
    var configuration: EmissionSectors =
    EmissionSectors(name: "Transport", iconName: "transport", colorName: "", percentageEmission: 0.20, sustainableActionFunction: [
        SustainableActionFunction(code: "investInPublicTransportation()", description: "Improving and expanding public transportation systems can encourage more people to use collective transportation instead of individual vehicles.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "expandElectricVehicleAccess()", description: "Increase infrastructure and access to electric vehicles gradually replacing those powered by fossil fuels.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "promoteAlternativeMobility()", description: "Develop strategies to make cities more pedestrian-friendly. Encourage the use of bicycles, walking, and other sustainable modes of transportation.", co2ReductionValue: 10, costEcoPoints: 2)
    ])
}

class DeforestationSector: EmissionSectorStrategy {
    
    var configuration: EmissionSectors =
    EmissionSectors(name: "Deforestation", iconName: "deforestation", colorName: "", percentageEmission: 0.10, sustainableActionFunction: [
        SustainableActionFunction(code: "protectForests()", description: "Establish and strengthen conservation areas, natural reserves, and national parks.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "forestRestoration()", description: "Initiate reforestation and restoration programs for degraded areas.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "deforestationInspection()", description: "Strengthen and expand monitoring to combat illegal logging and deforestation practices.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "raiseAwarenessDeforestation()", description: "Engage people in an accessible, educational, and inspiring manner, motivating them to advocate for forest preservation.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "forestFirePrevention()", description: "Involves monitoring and detection, community education, and effective firefighting infrastructure to prevent and combat forest fires.", co2ReductionValue: 10, costEcoPoints: 2)
    ])
}

class AgricultureSector: EmissionSectorStrategy {
    
    var configuration: EmissionSectors =
    EmissionSectors(name: "Agriculture", iconName: "agriculture", colorName: "", percentageEmission: 0.10, sustainableActionFunction: [
        SustainableActionFunction(code: "implementConservationAgriculture()", description: "Addresses several fundamental aspects such as soil cover preservation, water use efficiency, and contributes to carbon capture.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "wasteManagement()", description: "Promote recycling and reuse, implementing practices and processes to handle agricultural waste efficiently, safely, and sustainably.", co2ReductionValue: 10, costEcoPoints: 2),
        SustainableActionFunction(code: "promoteSustainableAgriculturalEducation()", description: "Promote awareness and train farmers in sustainable agricultural practices.", co2ReductionValue: 10, costEcoPoints: 2)
    ])
}

