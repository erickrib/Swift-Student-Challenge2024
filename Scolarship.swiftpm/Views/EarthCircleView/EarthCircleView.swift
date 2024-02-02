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
                        earthCircleViewModel.isComputerInterfaceVisible.toggle()
                        
                        return Void()
                    })
                }
                
                if earthCircleViewModel.isExecutionResult {
                    ExecutionResultView(messages: earthCircleViewModel.messages, co2Status: earthCircleViewModel.co2Status, onClose: {
                        earthCircleViewModel.isExecutionResult.toggle()
                        earthCircleViewModel.messages = []
                        
                        return Void()
                    })
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
