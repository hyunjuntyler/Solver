//
//  TierBadge.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

struct TierBadge: View {
    var tier: Int
    var size: CGFloat
    
    var body: some View {
        ZStack {
            TierBadgeShape()
                .frame(width: size * 0.7, height: size)
                .foregroundStyle(tier.tierBadgeColor)
            Text(tier.tierBadgeNumber)
                .foregroundStyle(.white)
                .fontWeight(.heavy)
                .fontDesign(.monospaced)
                .font(.system(size: size * 0.7))
                .offset(y: -size * 0.1)
        }
    }
}

fileprivate struct TierBadgeShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0, y: 0.0003*height))
        path.addLine(to: CGPoint(x: width, y: 0.0003*height))
        path.addLine(to: CGPoint(x: width, y: 0.66019*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.84255*height))
        path.addLine(to: CGPoint(x: 0, y: 0.66019*height))
        path.addLine(to: CGPoint(x: 0, y: 0.0003*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0, y: 0.73886*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.91905*height))
        path.addLine(to: CGPoint(x: width, y: 0.73886*height))
        path.addLine(to: CGPoint(x: width, y: 0.81707*height))
        path.addLine(to: CGPoint(x: 0.5*width, y: 0.99913*height))
        path.addLine(to: CGPoint(x: 0, y: 0.81707*height))
        path.addLine(to: CGPoint(x: 0, y: 0.73886*height))
        path.closeSubpath()
        return path
    }
}

#Preview {
    TierBadge(tier: 31, size: 30)
}
