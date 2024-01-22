//
//  SwiftUIView.swift
//  
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct ComputerBackgroundView: View {
    var body: some View {
        Image("modalBackground")
            .resizable()
            .scaledToFill()
            .frame(width: SCENE_SIZE.width * 0.95, height: SCENE_SIZE.height * 0.8)
    }
}

#Preview {
    ComputerBackgroundView()
}
