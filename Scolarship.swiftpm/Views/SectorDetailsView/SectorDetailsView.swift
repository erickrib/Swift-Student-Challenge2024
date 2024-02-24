//
//  File.swift
//
//
//  Created by Erick Ribeiro on 02/02/24.
//

import SwiftUI

struct SectorDetailsView: View {
    
    var onClose: () -> Void?
    var sector: EmissionSectorStrategy?
    
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    HStack{
                        Text(sector?.configuration.name ?? "")
                            .font(.title2.bold())
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
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
                
                let width = ImageWidth.width(forName: sector?.configuration.name ?? "")

                Image(sector?.configuration.imageDescription ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: width)                
                
                Text(sector?.configuration.description ?? "")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .padding(.vertical, 10)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Emissões Atuais:")
                            .font(.headline)
                        Text("Contribui com \(Int((sector?.configuration.percentageEmission ?? 0) * 100))% das emissões globais de CO\u{2082}, neste cenário.")
                            .font(.subheadline)
                            .padding(.leading, 15)
                    }
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("Meta de Redução de CO\u{2082}:")
                            .font(.headline)
                        Text("Reduzir as emissões em \(Int(sector?.configuration.reductionTarget ?? 0))CO\u{2082}.")
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
    }
}

enum ImageWidth: CGFloat {
    case small = 50
    case medium = 130
    case large = 300
    
    static func width(forName name: String) -> CGFloat {
        switch name {
        case "Industry":
            return ImageWidth.medium.rawValue
        case "Energy":
            return ImageWidth.medium.rawValue
        case "Transport":
            return ImageWidth.medium.rawValue
        case "Agriculture":
            return ImageWidth.medium.rawValue
        case "Deforestation":
            return ImageWidth.large.rawValue
        default:
            return ImageWidth.medium.rawValue
        }
    }
}
