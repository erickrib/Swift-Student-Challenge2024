//
//  SwiftUIView.swift
//
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SwiftUI
import SpriteKit

struct EarthCircleView: View {
    @StateObject var earthCircleViewModel = EarthCircleViewModel()
    @StateObject var emissionSectorManager: EmissionSectorManager = EmissionSectorManager(strategy: SectorInstance.industry.getInstance())
    @StateObject var codeEditorViewModel: CodeEditorViewModel = CodeEditorViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                
                SpriteView(scene: earthCircleViewModel.getScene(size: proxy.size))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if earthCircleViewModel.isComputerInterfaceVisible {
                    ComputerInterface(onClose: {
                        earthCircleViewModel.isComputerInterfaceVisible = false
                        
                        return Void()
                    })
                }
                
                if earthCircleViewModel.isExecutionResult {
                    ExecutionResultView(messages: earthCircleViewModel.messages, co2Status: earthCircleViewModel.co2Status, onClose: {
                        earthCircleViewModel.isExecutionResult = false
                        earthCircleViewModel.messages = []
                        
                        return Void()
                    })
                }
                
                if earthCircleViewModel.isSectorDetails {
                    SectorDetailsView(onClose: {
                        earthCircleViewModel.isSectorDetails = false
                        earthCircleViewModel.chosenSector = nil
                        
                        return Void()
                    }, sector: earthCircleViewModel.chosenSector
                    )
                }
            }
            .onAppear {
                print(proxy.size)
                SCENE_SIZE = proxy.size
                codeEditorViewModel.earthCircleViewModel = earthCircleViewModel
            }
            .environmentObject(emissionSectorManager)
            .environmentObject(codeEditorViewModel)
            .environmentObject(earthCircleViewModel)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    EarthCircleView()
}
