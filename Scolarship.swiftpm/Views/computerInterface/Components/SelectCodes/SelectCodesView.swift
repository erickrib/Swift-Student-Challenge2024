//
//  SwiftUIView.swift
//
//
//  Created by Erick Ribeiro on 22/01/24.
//

import SwiftUI

struct SelectCodesView: View {
    
    @EnvironmentObject var codeEditorViewModel: CodeEditorViewModel
    @EnvironmentObject var emissionSectorManager: EmissionSectorManager
    
    var onClose: () -> Void?
    
    var body: some View {
        ZStack{
            Image("backgroundListCode")
                .resizable()
                .scaledToFill()
            
            HStack{
                
                VStack{
                    
                    HStack(spacing: 15) {
                        Button(action: {
                            codeEditorViewModel.addLine()
                        }) {
                            Text("New line")
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                        
                        Button(action: {
                            codeEditorViewModel.removeLine()
                        }) {
                            Text("Remove")
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 25)
                    .padding(.bottom, 10)
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(.pink)
                    
                    Text("Click on the codes to add them to your algorithm:")
                        .padding(.vertical, 25.0)
                    
                    ScrollView {
                        
                        ForEach(emissionSectorManager.getSector(), id: \.self.id) { sector in
                            ExecutableCardCodeView()
                        }
                    }
                    
                }
                
                ZStack{
                    Image("selectSectorBackground")
                        .resizable()
                        .scaledToFill()
                    
                    VStack{
                        
                        Button(action: {
                            onClose()
                        }) {
                            Image(systemName: "xmark")
                                .resizable()
                        }
                        .frame(width: 20, height: 20)
                        .padding(.leading, 40)
                        .padding(.bottom, 30)
                        
                        Button(action: {
                            
                        }){
                            Image("selectSector")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 10.0)
                                .padding(.horizontal, 15.0)
                        }
                        Button(action: {
                            
                        }){
                            Image("selectSector")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 10.0)
                                .padding(.horizontal, 15.0)
                        }
                        Button(action: {
                            
                        }){
                            Image("selectSector")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 10.0)
                                .padding(.horizontal, 15.0)
                        }
                        Button(action: {
                            
                        }){
                            Image("selectSector")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 10.0)
                                .padding(.horizontal, 15.0)
                        }
                        Button(action: {
                            
                        }){
                            Image("selectSector")
                                .resizable()
                                .scaledToFit()
                                .padding(.vertical, 10.0)
                                .padding(.horizontal, 15.0)
                        }
                    }
                    
                }.frame(width: SCENE_SIZE.width * 0.082)
                
            }
            
        }
        .frame(width: SCENE_SIZE.width * 0.43, height: SCENE_SIZE.height * 0.77)
    }
}
