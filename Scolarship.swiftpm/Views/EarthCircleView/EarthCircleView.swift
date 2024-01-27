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
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                
                SpriteView(scene: earthCircleViewModel.getScene(size: proxy.size))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if earthCircleViewModel.isComputerInterfaceVisible {
                    ComputerInterface(onClose: {
                        earthCircleViewModel.isComputerInterfaceVisible.toggle()
                        earthCircleViewModel.isExecutionResult = true
                        
                        return Void()
                    })
                }
                
                if earthCircleViewModel.isExecutionResult {
                    ExecutionResultView(onClose: {
                        earthCircleViewModel.isExecutionResult.toggle()
                    })
                }
            }
            .onAppear {
                print(proxy.size)
                SCENE_SIZE = proxy.size
            }
            .environmentObject(emissionSectorManager)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    EarthCircleView()
}
