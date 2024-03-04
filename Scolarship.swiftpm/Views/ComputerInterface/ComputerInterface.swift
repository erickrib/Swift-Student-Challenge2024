//
//  ComputerInterface.swift
//
//
//  Created by Erick Ribeiro on 21/01/24.
//

import SwiftUI

struct ComputerInterface: View {
    
    @EnvironmentObject var codeEditorViewModel: CodeEditorViewModel

    var onClose: () -> Void?
    
    var body: some View {
        ZStack{
            ZStack {
                Image("modalBackground")
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color.black, lineWidth: 2)
                    )
                
                HStack(spacing: 0){
                    CodeEditorView()
                    SelectCodesView(onClose: onClose)
                }
            }
            .frame(width: SCENE_SIZE.width > 1300 ? SCENE_SIZE.width * 0.90 : SCENE_SIZE.width * 0.95, height:SCENE_SIZE.width > 1300 ? SCENE_SIZE.height * 0.8 : SCENE_SIZE.height * 0.84)
            .background(.clear)

        }
        .frame(width: SCENE_SIZE.width, height: SCENE_SIZE.height)
        .background(
            Color.black
            .opacity(0.5)
            .edgesIgnoringSafeArea(.all)
            .onTapGesture {
                onClose()
            }
        )
    }
}

#Preview{
    ComputerInterface(onClose: {})
}