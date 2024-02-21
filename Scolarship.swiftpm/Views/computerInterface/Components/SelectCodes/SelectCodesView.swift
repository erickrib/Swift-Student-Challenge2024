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
                    
                    HStack {
                        
                        HStack{
                            Image(systemName: "leaf.fill")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(Color.green)
                            
                            Text("\(codeEditorViewModel.ecopoints)")
                                .foregroundStyle(Color.green)
                        }
                        .padding(.all, 10.0)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("bluePrimary"))
                        )
                        
                        Spacer()
                        
                        Button(action: {
                            codeEditorViewModel.removeLine()
                        }) {
                            Text("Remove")
                                .padding(.horizontal, 60)
                                .padding(.vertical, 15)
                                .background(Color.red)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 5))
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 25)
                    .padding(.bottom, 10)
                    
                    Divider()
                        .frame(height: 1)
                        .overlay(Color("bluePrimary"))
                    
                    Text("Click on the codes to add them to your algorithm:")
                        .padding(.vertical, 25.0)
                        .foregroundStyle(Color("bluePrimary"))
                    
                    ScrollView {
                        ForEach(emissionSectorManager.getSector().sustainableActionFunction) { function in
                            ExecutableCardCodeView(sustainableActionFunction: function, disable: codeEditorViewModel.ecopoints < function.costEcoPoints)
                                .onTapGesture {
                                    codeEditorViewModel.addFunction(action: function)
                                }
                                .disabled(codeEditorViewModel.ecopoints < function.costEcoPoints)
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
                        .background(
                            Circle()
                                .fill(Color(uiColor: .secondarySystemBackground))
                                .frame(width: 32, height: 32)
                        )
                        .foregroundColor(Color("bluePrimary"))
                        .padding(.leading, 40)
                        .padding(.top, 20)
                        .padding(.bottom, 20)
                        
                        ForEach(SectorInstance.allCases, id: \.self){ sector in 
                            Button(action: {
                                emissionSectorManager.strategy = sector.getInstance()
                            }){
                                Image(sector.getInstance().configuration.iconName)
                                    .resizable()
                                    .scaledToFit()
                                    .padding(.vertical, 10.0)
                                    .padding(.horizontal, 5.0)
                            }
                        }
                    }
                    
                }.frame(width: SCENE_SIZE.width * 0.09)
                
            }
            
        }
        .frame(width: SCENE_SIZE.width * 0.43, height: SCENE_SIZE.height * 0.77)
    }
}
