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
    @Published var touchPosition: CGFloat = 0.8
    
    @Published var ecopoints: Int = 30
    var earthCircleViewModel: EarthCircleViewModel?
    
    func addFunction(action:SustainableActionFunction) {
        
        ecopoints -= action.costEcoPoints
        
        guard let index = selectedLineIndex else {
            codeLines.append(action)
            selectedLineIndex = codeLines.count - 1
            updateCustomValues()
            return
        }
        
        if  codeLines[index].code == "" {
            codeLines.remove(at: index)
            codeLines.insert(action, at: index)
        } else {
            if touchPosition < 0.3 && index == 0 {
                codeLines.insert(action, at: index)
                selectedLineIndex = index
            } else {
                codeLines.insert(action, at: index + 1)
                selectedLineIndex = index + 1
            }
        }
        
        updateCustomValues()
    }
    
    func addLine() {
        let emptyFunction = SustainableActionFunction(code: "", description: "", co2ReductionValue: 0, costEcoPoints: 0)
        
        guard let index = selectedLineIndex else {
            codeLines.append(emptyFunction)
            selectedLineIndex = codeLines.count - 1
            
            return
        }
        
        if !(codeLines[index].code == "") {
            
            if touchPosition < 0.3 && index == 0 {
                codeLines.insert(emptyFunction, at: index)
                selectedLineIndex = index
            } else {
                codeLines.insert(emptyFunction, at: index + 1)
                selectedLineIndex = index + 1
            }
        }
    }
    
    
    func removeLine() {
        
        guard !codeLines.isEmpty else {
            selectedLineIndex = nil
            updateCustomValues()
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
        
        updateCustomValues()
    }
    
    func runCode() {
        earthCircleViewModel?.changeCO2Status(actions: codeLines)
    }
    
    private func updateCustomValues() {
        for (index, _) in codeLines.enumerated() {
            let bonusPercentual: [Double] = [0.25, 0.20, 0.15, 0.10, 0.05, 0.03, 0.02]
            if index <= bonusPercentual.count - 1{
                codeLines[index].bonus = bonusPercentual[index]
            }
        }
    }
}
