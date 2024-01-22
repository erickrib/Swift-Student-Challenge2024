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
            .clipShape(RoundedRectangle(cornerRadius: 25))
            .overlay(
                RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}

#Preview {
    ComputerBackgroundView()
}
