//
//  StartView.swift
//
//
//  Created by Erick Ribeiro on 24/02/24.
//

import SwiftUI

struct StartView: View {
    
    @Binding var showSpriteView: Bool
    @State private var text = ""
    @State private var index: Int = 0
    @State private var isCursorVisible = true
    let fullText = "Code Carbon"
    let cursor = "|"
    let timer = Timer.publish(every: 0.25, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        VStack {
            VStack {
                HStack(spacing: 0) {
                    Text("{ \(text)\(isCursorVisible ? cursor : index < fullText.count ? " " : "") }")
                        .font(.system(size: 64))
                        .foregroundColor(.white)
                    
                }
                .onReceive(timer) { _ in
                    if index < fullText.count {
                        let letter = fullText[fullText.startIndex...fullText.index(fullText.startIndex, offsetBy: index)]
                        self.text = String(letter)
                        index += 1
                    }
                    
                    if index < fullText.count {
                        withAnimation {
                            isCursorVisible.toggle()
                        }
                    } else {
                        isCursorVisible = false
                    }
                    
                }
                .padding(.top, 40)
            }
            
            
            Image("planetStart")
                .resizable()
                .frame(width: 240, height: 240)
            
            Text("Help the planet tackle climate change through programming")
                .font(.system(size: 28))
                .foregroundStyle(.white)
                .padding(.vertical, 40)
            
            Button(action: {
                showSpriteView = true
            }) {
                Text("Start")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.green)
                    .cornerRadius(10)
            }
        }
    }
}
