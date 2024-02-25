//
//  ExecutionResultView.swift
//
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct ExecutionResultView: View {
    
    @EnvironmentObject var earthCircleViewModel:EarthCircleViewModel

    var messages:[Message]
    var co2Status:CO2Status
    
    @State var allSuccessMessages: Bool = false
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading) {
                HStack {
                    HStack(spacing: 180){
                        Text("Execution Result:")
                            .font(.title3.bold())
                        
                        let formattedInitial = String(format: "%.1f", co2Status.initial).replacingOccurrences(of: ".", with: ",")
                        let formattedCurrent = String(format: "%.1f", co2Status.current).replacingOccurrences(of: ".", with: ",")
                        HStack(spacing: 20){
                            VStack(alignment: .center){
                                Text("Previous")
                                    .font(.system(size: 16, weight: .bold))
                                
                                Text("\(formattedInitial) CO\u{2082}")
                            }
                            Text("->")
                            VStack(alignment: .center){
                                Text("Now")
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundStyle(.blue)
                                
                                Text("\(formattedCurrent) CO\u{2082}")
                            }
                        }
                    }
                    
                    Spacer()
                    
                    Button {
                        earthCircleViewModel.isExecutionResult = false
                        earthCircleViewModel.messages = []
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
                
                if allSuccessMessages {
                    VStack(alignment: .leading, spacing: 20){
                        HStack{
                            Text("Mission Complete: You've Balanced Emissions!")
                                    .font(.title3.bold())
                                    .foregroundStyle(Color("bluePrimary"))
                        }.frame(maxWidth: .infinity, alignment: .center)
                            
                        Text("Programming is a tool for change. It allows us to create impactful solutions that drive real-world environmental progress, making it possible to help both people and the planet. In this app, you can code a better world.")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                        
                        Text("Together, we can continue working to address the challenges of climate change and create a better world for future generations. Thank you for being part of this journey!")
                            .font(.system(size: 16))
                            .foregroundStyle(.black)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 30)
                }
                
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
                
                Divider()
                HStack{
                    Button(action: {
                        earthCircleViewModel.isExecutionResult = false
                        earthCircleViewModel.messages = []
                    }) {
                        Text("View Scenario")
                            .font(.system(size: 14))
                            .fontWeight(.bold)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color("bluePrimary"))
                            .cornerRadius(8)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 10)
            }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
            .frame(maxWidth: 680, maxHeight: allSuccessMessages ? 700 : 435)
        }
        .frame(width: SCENE_SIZE.width, height: SCENE_SIZE.height)
        .background(
            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    earthCircleViewModel.isExecutionResult = false
                    earthCircleViewModel.messages = []
                }
        )
        .onAppear{
            let allSuccess = messages.allSatisfy { $0.isSuccess }
            if allSuccess {
                allSuccessMessages = true
            } else {
                allSuccessMessages = false
            }
        }
    }
}

