//
//  SwiftUIView.swift
//  
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct CodeEditorView: View {
    var body: some View {
        Image("codeEditor")
            .resizable()
            .scaledToFill()
            .frame(width: SCENE_SIZE.width * 0.49, height: SCENE_SIZE.height * 0.77)
    }
}

#Preview {
    CodeEditorView()
}
