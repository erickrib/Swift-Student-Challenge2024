//
//  SwiftUIView.swift
//
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct ExecutionResultView: View {
    
    var message:String
    var onClose: () -> Void?

    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                HStack {
                    Text("Execution Result")
                        .font(.title3.bold())
                    
                    Spacer()
                    
                    Button {
                        onClose()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .background(
                                Circle()
                                    .fill(Color(uiColor: .secondarySystemBackground))
                                    .frame(width: 32, height: 32)
                            )
                            .foregroundColor(Color(uiColor: .label))
                    }
                }
                .padding(.horizontal, 30)
                .padding(.vertical, 15)
                
                Divider()
                
                Text(message)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
            .frame(maxWidth: 680, maxHeight: 720)
            .offset(y: SCENE_SIZE.height * 0.191)
        }
        .frame(width: SCENE_SIZE.width, height: SCENE_SIZE.height)
        .background(
            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    
                }
        )
    }
}
