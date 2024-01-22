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
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                
                SpriteView(scene: earthCircleViewModel.getScene(size: proxy.size))
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                if earthCircleViewModel.showingSheet {
                    ComputerInterface(onClose: {
                                            earthCircleViewModel.showingSheet.toggle()
                                        })
                }
            }
            .onAppear {
                print(proxy.size)
                SCENE_SIZE = proxy.size
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    EarthCircleView()
}
