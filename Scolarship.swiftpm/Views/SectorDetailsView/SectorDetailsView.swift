//
//  File.swift
//
//
//  Created by Erick Ribeiro on 02/02/24.
//

import SwiftUI

struct SectorDetailsView: View {
    
    @EnvironmentObject var emissionSectorManager: EmissionSectorManager
    var onClose: () -> Void?
    var sector: EmissionSectorStrategy?
    
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    HStack{
                        Text(emissionSectorManager.strategy.configuration.name)
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    Button {
                        onClose()
                        emissionSectorManager.strategy = SectorInstance.industry.getInstance()
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
                
                Image("modalBackground")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: 200, maxHeight: 200)
                
                
                Text(emissionSectorManager.strategy.configuration.description)
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 30)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Emissões Atuais:")
                            .font(.headline)
                        Text("Contribui com \(Int(emissionSectorManager.strategy.configuration.percentageEmission * 100))% das emissões globais de CO2, nesta simulação.")
                            .font(.subheadline)
                            .padding(.leading, 15)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Meta de Redução de CO2:")
                            .font(.headline)
                        Text("Reduzir as emissões em \(Int(emissionSectorManager.strategy.configuration.reductionTarget ?? 0))CO2.")
                            .font(.subheadline)
                            .padding(.leading, 15)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)

            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.white)
            )
            .frame(maxWidth: 480, maxHeight: 520)
        }
        .frame(width: SCENE_SIZE.width, height: SCENE_SIZE.height)
        .background(
            Color.black
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .onTapGesture {
                    
                }
        )
        .onAppear{
            if let sectorModal = self.sector{
                emissionSectorManager.strategy = sectorModal
            }
        }
    }
}

