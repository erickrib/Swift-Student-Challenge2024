//
//  File.swift
//
//
//  Created by Erick Ribeiro on 23/01/24.
//

import Foundation
import SwiftUI

class CodeEditorViewModel: ObservableObject {
    
    @Published var codeLines: [SustainableActionFunction] = []
    @Published var selectedLineIndex: Int?
    
    @Published var ecopoints: Int = 30
    var earthCircleViewModel: EarthCircleViewModel?
    
    func addFunction(action:SustainableActionFunction) {
        
        ecopoints -= action.costEcoPoints
        
        guard let index = selectedLineIndex else {
            codeLines.append(action)
            selectedLineIndex = codeLines.count - 1
            return
        }
        
        if  codeLines[index].code == "" {
            codeLines.remove(at: index)
            codeLines.insert(action, at: index)
        } else {
            codeLines.insert(action, at: index + 1)
            selectedLineIndex = index + 1
        }
    }
    
    func addLine() {
        let emptyFunction = SustainableActionFunction(code: "", description: "", co2ReductionValue: 0, costEcoPoints: 0)
        
        guard let index = selectedLineIndex else {
            codeLines.append(emptyFunction)
            selectedLineIndex = codeLines.count - 1
            
            return
        }
        
        if !(codeLines[index].code == "") {
            codeLines.insert(emptyFunction, at: index + 1)
            selectedLineIndex = index + 1
        }
    }
    
    
    func removeLine() {
        
        guard !codeLines.isEmpty else {
            selectedLineIndex = nil
            return
        }
        
        if let index = selectedLineIndex {
            ecopoints += codeLines[index].costEcoPoints
            
            codeLines.remove(at: index)
            selectedLineIndex = index == 0 && codeLines.isEmpty ? nil : max(0, index - 1)
            
        } else {
            ecopoints += codeLines[codeLines.count - 1].costEcoPoints
            codeLines.remove(at: codeLines.count - 1)
        }
    }
    
    func runCode() {
        var co2Reduction:Double = 0
        
        for sustainableFunction in codeLines {
            co2Reduction += sustainableFunction.co2ReductionValue
        }
        
        earthCircleViewModel?.changeCO2Status(value: co2Reduction)
    }
}
