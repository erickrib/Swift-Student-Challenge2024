//
//  SwiftUIView.swift
//
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct CodeEditorView: View {
    var body: some View {
        ZStack{
            Image("codeEditor")
                .resizable()
                .scaledToFill()
            
            VStack (alignment: .leading, spacing: 200){
                HStack{
                    Button(action: {
                        
                    }){
                        HStack {
                            Image(systemName: "play.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.white)
                                .frame(width: 26, height: 24)
                            
                            Text("Run")
                                .foregroundColor(Color.white)
                        }
                        .padding(.all, 10.0)
                        .frame(width: 92, height: 45)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.green))
                    }
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName: "leaf.fill")
                            .resizable()
                            .frame(width: 25, height: 25)
                        
                        Text("30")
                            .foregroundColor(Color.black)
                    }
                    .padding(.all, 10.0)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.white))
                }
                .padding([.top], 25)
                
                Text("testandoFuncao()")
                    .font(.system(size: 26))
                    .foregroundColor(Color.white)

                Spacer()
            }
            .padding([.leading, .trailing], 20)
            .frame(maxHeight: .infinity)
        }
        .frame(width: SCENE_SIZE.width * 0.49, height: SCENE_SIZE.height * 0.77)
    }
}

#Preview {
    CodeEditorView()
}
