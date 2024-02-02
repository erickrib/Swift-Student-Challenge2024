//
//  SwiftUIView.swift
//
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct ExecutionResultView: View {
    
    var messages:[Message]
    var co2Status:CO2Status
    var onClose: () -> Void?
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                HStack {
                    HStack(spacing: 180){
                        Text("Execution Result:")
                            .font(.title3.bold())
                        
                        Text("\(Int(co2Status.initial))CO\u{2082}    ->     \(Int(co2Status.current))CO\u{2082}" )
                    }
                    
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
                .padding(.top, 15)
                .padding(.bottom, 10)
                .padding(.trailing, 30)
                .padding(.leading, 30)

                
                Divider()
                
                ScrollView{
                    ForEach(messages){ message in
                        if message.isSuccess {
                                HStack{
                                    Image(systemName: "checkmark.circle.fill")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundStyle(Color.green)
                                        .frame(width: 26, height: 24)
                                    Text(message.successMessage)
                                }
                                .padding(.horizontal, 30)
                                .padding(.vertical, 10)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                                Divider()
                        } else {
                            HStack{
                                Image(systemName: "xmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundStyle(Color.red)
                                    .frame(width: 26, height: 24)
                                Text(message.errorMessage)
                            }
                            .padding(.horizontal, 30)
                            .padding(.vertical, 10)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            
                            Divider()
                        }
                    }
                }
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
            .frame(maxWidth: 680, maxHeight: 320)
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

