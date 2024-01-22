//
//  SwiftUIView.swift
//  
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct ExecutableCardCodeView: View {
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .fill(.white)
            
            VStack(alignment: .trailing){
                HStack{
                    Text("TestandoFunção()")
                        .padding(.bottom, 5.0)
                    Spacer()
                    HStack{
                        Image(systemName: "leaf.fill")
                        Text("8")
                            .padding(.trailing, 10.0)
                    }
                }
                Text("Colaborar com fornecedores que adotam práticas sustentáveis, garantindo uma cadeia de suprimentos mais verde.")
                    .font(.system(size: 14))
                
                Text("-10 CO\u{2082}")
                    .font(.system(size: 14))
                    .padding(.trailing, 10.0)

            }
            .padding(.horizontal, 10.0)
            .padding(.vertical, 12.0)
            
        }
        .frame(width: SCENE_SIZE.width * 0.31)
        .padding([.leading, .bottom], 10.0)
        .padding(.trailing, 15.0)
    }
}

#Preview {
    ExecutableCardCodeView()
}
