//
//  SwiftUIView.swift
//  
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct ExecutableCardCodeView: View {
    
    var sustainableActionFunction: SustainableActionFunction
    var disable:Bool
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 5)
                .fill(disable ? Color.blue : Color.white)

            VStack(alignment: .trailing){
                HStack{
                    Text(sustainableActionFunction.code)
                        .padding(.bottom, 5.0)
                    Spacer()
                    HStack{
                        Image(systemName: "leaf.fill")
                        Text("\(sustainableActionFunction.costEcoPoints)")
                            .padding(.trailing, 10.0)
                    }
                }
                Text(sustainableActionFunction.description)
                    .font(.system(size: 14))
                
                Text("-\(Int(sustainableActionFunction.co2ReductionValue)) CO\u{2082}")
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
