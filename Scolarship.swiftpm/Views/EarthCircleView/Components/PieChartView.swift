//
//  PieChartView.swift
//
//
//  Created by Erick Ribeiro on 07/12/23.
//

import SwiftUI

struct PieChartView: View {
    @State private var slices: [(Double, Color)] = [
        (3, .orange),
        (1, Color("pieGreen"))
    ]
    @EnvironmentObject var earthCircleViewModel:EarthCircleViewModel

    
    var body: some View {
        ZStack {
            
            Circle()
                .fill(Color("PieBack"))
                .frame(width: SCENE_SIZE.width > 1300 ? SCENE_SIZE.width * 0.15 : SCENE_SIZE.width * 0.127, height: SCENE_SIZE.height * 0.182)

            Text("absorption")
                .padding(.top, 68.0)
                .font(.system(size: SCENE_SIZE.width > 1300 ? 18 : 14))
                .foregroundStyle(Color("absorption"))
            
            Canvas { context, size in
                let donut = Path { p in
                    p.addEllipse(in: CGRect(origin: .zero, size: size))
                    p.addEllipse(in: CGRect(x: size.width * 0.25, y: size.height * 0.25, width: size.width * 0.5, height: size.height * 0.5))
                }
                
                context.clip(to: donut, style: .init(eoFill: true))
                
                let total = slices.reduce(0) { $0 + $1.0 }
                context.translateBy(x: size.width * 0.5, y: size.height * 0.5)
                
                let radius = min(size.width, size.height) * 0.3
                
                var startAngle = Angle(degrees: -180)
                
                for (value, color) in slices {
                    let angle = Angle(degrees: 360 * (value / total))
                    let endAngle = startAngle + angle
                    
                    let path = Path { p in
                        p.move(to: .zero)
                        p.addArc(center: .zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
                        p.closeSubpath()
                    }
                    
                    context.fill(path, with: .color(color))
                    startAngle = endAngle
                }
                
            }
            .aspectRatio(1, contentMode: .fit)
            
            Circle()
                .stroke(Color.white, lineWidth: 2)
                .frame(width: SCENE_SIZE.width > 1300 ? SCENE_SIZE.width * 0.15 : SCENE_SIZE.width * 0.127, height: SCENE_SIZE.height * 0.182)

            
            Text("\(Int(earthCircleViewModel.co2Status.current)) CO\u{2082}")
                .font(.system(size: SCENE_SIZE.width > 1300 ? 20 : 18))
                .padding(.bottom, 0)
                .foregroundStyle(.white)
            
            Text("emission")
                .padding(.bottom, 78.0)
                .font(.system(size: SCENE_SIZE.width > 1300 ? 18 : 14))
                .foregroundStyle(.orange)
        }
        .onChange(of: earthCircleViewModel.co2Status.current) { newValue in
            let baseReduceEmission = earthCircleViewModel.co2Status.initial - earthCircleViewModel.co2Status.goal
            let newEmission = earthCircleViewModel.co2Status.initial - earthCircleViewModel.co2Status.current

            let normalizedValue = max(0, min(1, newEmission / baseReduceEmission))

            let mappedValue = 3 - 2 * normalizedValue

            let newEmissionSlice = max(1, min(3, mappedValue))
            
            // Updates graph value
            slices = [
                (newEmissionSlice, .orange),
                (1, Color("pieGreen"))
            ]
        }

    }
}

#Preview {
    PieChartView()
}
