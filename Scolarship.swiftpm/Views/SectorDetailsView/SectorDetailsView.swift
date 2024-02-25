//
//  SectorDetailsView.swift
//
//
//  Created by Erick Ribeiro on 02/02/24.
//

import SwiftUI

struct SectorDetailsView: View {
    
    @EnvironmentObject var earthCircleViewModel:EarthCircleViewModel
    var sector: EmissionSectorStrategy?
    
    var body: some View {
        ZStack{
            VStack {
                HStack {
                    HStack{
                        Text(sector?.configuration.name ?? "")
                            .font(.title2.bold())
                            .foregroundStyle(.black)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    Spacer()
                    
                    Button {
                        earthCircleViewModel.isSectorDetails = false
                        earthCircleViewModel.chosenSector = nil
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
                        Text("Current Emissions:")
                            .font(.headline)
                        Text("Contributes \(Int((sector?.configuration.percentageEmission ?? 0) * 100))% of global de CO\u{2082} emissions in this scenario.")
                            .font(.subheadline)
                            .padding(.leading, 15)
                    }
                    .foregroundStyle(.black)
                    
                    Spacer()
                }
                .padding(.bottom, 20)
                
                HStack{
                    VStack(alignment: .leading){
                        Text("CO\u{2082} Reduction Goal:")
                            .font(.headline)
                        
                        if let reductionTarget = sector?.configuration.reductionTarget, reductionTarget != 0 {
                            let formattedString = String(format: "%.1f", reductionTarget).replacingOccurrences(of: ".", with: ",")
                            Text("Reduce emissions by \(formattedString) CO\u{2082}.")
                                .font(.subheadline)
                                .padding(.leading, 15)
                            
                            HStack {
                                Image(systemName: "xmark.circle")
                                    .foregroundStyle(.white)
                                
                                Text("Pending Goal")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(.red)
                            .cornerRadius(10)
                            .padding(.leading, 15)
                        } else {
                            Text("Reduce emissions by 0 CO\u{2082}.")
                                .font(.subheadline)
                                .padding(.leading, 15)
                            
                            HStack {
                                Image(systemName: "checkmark.circle")                                .foregroundStyle(.white)
                                
                                Text("Completed Goal")
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 5)
                            .background(.green)
                            .cornerRadius(10)
                            .padding(.leading, 15)
                        }
                        
                    }
                    .foregroundStyle(.black)
                    
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
                    earthCircleViewModel.isSectorDetails = false
                    earthCircleViewModel.chosenSector = nil
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
