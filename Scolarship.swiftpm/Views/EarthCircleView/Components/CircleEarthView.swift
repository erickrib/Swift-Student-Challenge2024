//
//  File.swift
//  
//
//  Created by Erick Ribeiro on 06/12/23.
//

import SwiftUI
import Charts

struct CircleEarthView: View {
    
    var body: some View {
        ZStack {
            
            Path { path in
                let outerRadiusX: CGFloat = 300
                let outerRadiusY: CGFloat = 270
                let outerCenter = CGPoint(x: 300, y: 270)
                path.addEllipse(in: CGRect(x: outerCenter.x - outerRadiusX, y: outerCenter.y - outerRadiusY, width: outerRadiusX * 2, height: outerRadiusY * 2))
            }
            .fill(Color("earthEdge"))
            
            Path { path in
                let innerRadiusX: CGFloat = 300 * 0.90
                let innerRadiusY: CGFloat = 270 * 0.90
                let innerCenter = CGPoint(x: 300, y: 270)
                
                path.addEllipse(in: CGRect(x: innerCenter.x - innerRadiusX, y: innerCenter.y - innerRadiusY, width: innerRadiusX * 2, height: innerRadiusY * 2))
            }
            .fill(Color("earth"))
            
            Path { path in
                let startPoint = CGPoint(x: 5, y: 285)
                let endPoint = CGPoint(x: 600, y: 285)
                path.move(to: startPoint)
                path.addLine(to: endPoint)
            }
            .stroke(style: StrokeStyle(lineWidth: 1, dash: [4]))
            .foregroundColor(Color.white)
        }
        .frame(width: 600, height: 540)
    }
}


#Preview {
    CircleEarthView()
}

