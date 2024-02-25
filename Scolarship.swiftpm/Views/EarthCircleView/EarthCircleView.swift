//
//  EarthCircleView.swift
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
    
    @State var showSpriteView:Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                if (!showSpriteView){
                    // Home screen
                    StartView(showSpriteView: $showSpriteView)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color("bluePrimary"))
                    
                } else {
                    // Game Scene
                    SpriteView(scene: earthCircleViewModel.getScene(size: proxy.size))
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                
                if earthCircleViewModel.isComputerInterfaceVisible {
                    // Computer choice of codes
                    ComputerInterface(onClose: {
                        earthCircleViewModel.isComputerInterfaceVisible = false
                    })
                }
                
                if earthCircleViewModel.isExecutionResult {
                    // Execution result modal
                    ExecutionResultView(messages: earthCircleViewModel.messages, co2Status: earthCircleViewModel.co2Status)
                }
                
                
                if earthCircleViewModel.isSectorDetails {
                    // Modal sector details
                    SectorDetailsView(sector: earthCircleViewModel.chosenSector)
                }
                
                if earthCircleViewModel.isDoubt && showSpriteView {
                    // Tutorial modal and questions
                    DoubtView()
                }
            }
            .preferredColorScheme(.light)
            .onAppear {
                codeEditorViewModel.earthCircleViewModel = earthCircleViewModel
                SCENE_SIZE = CGSize(width: proxy.size.width > proxy.size.height ? proxy.size.width : proxy.size.height, height: proxy.size.width > proxy.size.height ? proxy.size.height : proxy.size.width)


                NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                                
                    SCENE_SIZE = CGSize(width: proxy.size.width > proxy.size.height ? proxy.size.width : proxy.size.height, height: proxy.size.width > proxy.size.height ? proxy.size.height : proxy.size.width)
                    
                    earthCircleViewModel.changeCO2Status(actions: [])
                }
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
