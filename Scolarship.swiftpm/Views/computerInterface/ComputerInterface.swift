//
//  File.swift
//
//
//  Created by Erick Ribeiro on 21/01/24.
//

import SwiftUI

struct ComputerInterface: View {
    
    var onClose: () -> Void?
    
    var body: some View {
        ZStack{
            ZStack {
                ComputerBackgroundView()
                HStack(spacing: 10){
                    CodeEditorView()
                    SelectCodesView()
                }
            }
            .background(.clear)

        }
        .frame(width: SCENE_SIZE.width, height: SCENE_SIZE.height)
        .background(
            Color.black
            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                onClose() // Fecha o modal ao clicar fora dele
            }
        )
    }
}

#Preview{
    ComputerInterface(onClose: {})
}
