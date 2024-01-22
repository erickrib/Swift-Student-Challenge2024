//
//  SwiftUIView.swift
//
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct SelectCodesView: View {
    var body: some View {
        ZStack{
            Image("backgroundListCode")
                .resizable()
                .scaledToFill()
                .frame(width: SCENE_SIZE.width * 0.43, height: SCENE_SIZE.height * 0.77)
            
            HStack{
                VStack{
                    HStack(spacing: 15) {
                        Button(action: {
                            // Ação do primeiro botão
                            print("Botão 1 pressionado!")
                        }) {
                            Text("New line")
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        
                        Button(action: {
                            // Ação do segundo botão
                            print("Botão 2 pressionado!")
                        }) {
                            Text("Remove")
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                    
                    Divider()
                    
                    Text("Click on the codes to add them to your algorithm:")
                    
                }
                
                VStack{
                    Image("selectSectorBackground")
                        .resizable()
                        .scaledToFill()
                        .frame(width: SCENE_SIZE.width * 0.082, height: SCENE_SIZE.width * 0.43)
                }
            }
        }
        .frame(width: SCENE_SIZE.width * 0.43, height: SCENE_SIZE.height * 0.77)
    }
}

#Preview {
    SelectCodesView()
}
