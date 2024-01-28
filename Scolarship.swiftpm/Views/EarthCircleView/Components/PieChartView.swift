//
//  SwiftUIView.swift
//
//
//  Created by Erick Ribeiro on 07/12/23.
//

import SwiftUI

struct PieChartView: View {
    @State private var slices: [(Double, Color)] = [
        (1, .red),
        (1, .orange)
    ]
    
    @EnvironmentObject var earthCircleViewModel:EarthCircleViewModel

    
    var body: some View {
        ZStack {
            
            Circle()
                .fill(.blue)
                .frame(width: 152, height: 152)
            
            Text("absorption")
                .padding(.top, 70.0)
                .font(.system(size: 14))
            
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
                .frame(width: 152, height: 152)
            
            Text("\(Int(earthCircleViewModel.co2Status.current)) CO\u{2082}")
                .font(.system(size: 18))
                .padding(.bottom, 0)
            
            Text("emission")
                .padding(.bottom, 80.0)
                .font(.system(size: 14))
        }
    }
}

#Preview {
    PieChartView()
}
