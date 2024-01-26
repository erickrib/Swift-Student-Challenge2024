//
//  File.swift
//
//
//  Created by Erick Ribeiro on 23/01/24.
//

import Foundation
import SwiftUI

class CodeEditorViewModel: ObservableObject {
    
    @Published var codeLines: [String] = [
        "helloWorld()",
        "helloWorld()",
    ]
    
    @Published var selectedLineIndex: Int?
    
    func addFunction() {
    }
    
    func removeFunction(){
        
    }
    
    func addLine() {
        
        if let index = selectedLineIndex {
            if !(codeLines[index] == "") {
                codeLines.insert("", at: index + 1)
                selectedLineIndex = index + 1
            }
        } else {
            codeLines.append("")
            selectedLineIndex = codeLines.count - 1
        }
    }
    
    
    func removeLine() {
        if !codeLines.isEmpty {
            if let index = selectedLineIndex {
                codeLines.remove(at: index)
            } else {
                codeLines.remove(at: codeLines.count - 1)
            }
        }
        
        self.selectedLineIndex = nil
    }
}
