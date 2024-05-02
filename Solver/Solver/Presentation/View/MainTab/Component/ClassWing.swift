//
//  ClassWing.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/30/24.
//

import SwiftUI

struct ClassWing: View {
    var decoration: String
    var size: CGFloat
    
    private var color: Color {
        switch decoration {
        case "silver": .silver
        case "gold": .gold
        default: .clear
        }
    }
    
    var body: some View {
        ClassWingShape()
            .frame(width: size * 1.2, height: size * 0.8)
            .foregroundStyle(color)
            .shimmerEffect()
            .frame(width: size, height: size, alignment: .top)
    }
}

#Preview {
    ZStack {
        ClassWing(decoration: "silver", size: 30)
        ClassBadge(userClass: 1, size: 30)
    }
}

struct ClassWingShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.size.width
        let height = rect.size.height
        path.move(to: CGPoint(x: 0.85316*width, y: 0.05886*height))
        path.addCurve(to: CGPoint(x: 0.55091*width, y: 0.92548*height), control1: CGPoint(x: 0.80321*width, y: 0.40679*height), control2: CGPoint(x: 0.72084*width, y: 0.65691*height))
        path.addCurve(to: CGPoint(x: 0.56156*width, y: 0.99123*height), control1: CGPoint(x: 0.5369*width, y: 0.94761*height), control2: CGPoint(x: 0.54222*width, y: 0.98579*height))
        path.addCurve(to: CGPoint(x: 0.75728*width, y: 0.96094*height), control1: CGPoint(x: 0.61732*width, y: 1.00692*height), control2: CGPoint(x: 0.67596*width, y: 0.9952*height))
        path.addCurve(to: CGPoint(x: 0.93937*width, y: 0.76993*height), control1: CGPoint(x: 0.82961*width, y: 0.91583*height), control2: CGPoint(x: 0.89139*width, y: 0.84955*height))
        path.addCurve(to: CGPoint(x: 0.92686*width, y: 0.74368*height), control1: CGPoint(x: 0.94871*width, y: 0.75445*height), control2: CGPoint(x: 0.93892*width, y: 0.73426*height))
        path.addCurve(to: CGPoint(x: 0.82362*width, y: 0.80209*height), control1: CGPoint(x: 0.89483*width, y: 0.76871*height), control2: CGPoint(x: 0.85808*width, y: 0.79512*height))
        path.addCurve(to: CGPoint(x: 0.98936*width, y: 0.51269*height), control1: CGPoint(x: 0.91438*width, y: 0.71758*height), control2: CGPoint(x: 0.96516*width, y: 0.62611*height))
        path.addCurve(to: CGPoint(x: 0.97135*width, y: 0.49253*height), control1: CGPoint(x: 0.99319*width, y: 0.49469*height), control2: CGPoint(x: 0.98092*width, y: 0.48135*height))
        path.addCurve(to: CGPoint(x: 0.8835*width, y: 0.56771*height), control1: CGPoint(x: 0.94494*width, y: 0.52343*height), control2: CGPoint(x: 0.915*width, y: 0.55606*height))
        path.addCurve(to: CGPoint(x: 0.87678*width, y: 0.05412*height), control1: CGPoint(x: 0.92704*width, y: 0.37351*height), control2: CGPoint(x: 0.92728*width, y: 0.2298*height))
        path.addCurve(to: CGPoint(x: 0.85316*width, y: 0.05886*height), control1: CGPoint(x: 0.8717*width, y: 0.03644*height), control2: CGPoint(x: 0.85588*width, y: 0.03987*height))
        path.closeSubpath()
        path.move(to: CGPoint(x: 0.14523*width, y: 0.05625*height))
        path.addCurve(to: CGPoint(x: 0.44748*width, y: 0.92288*height), control1: CGPoint(x: 0.19517*width, y: 0.40418*height), control2: CGPoint(x: 0.27754*width, y: 0.65431*height))
        path.addCurve(to: CGPoint(x: 0.43682*width, y: 0.98863*height), control1: CGPoint(x: 0.46148*width, y: 0.94501*height), control2: CGPoint(x: 0.45616*width, y: 0.98319*height))
        path.addCurve(to: CGPoint(x: 0.2411*width, y: 0.95834*height), control1: CGPoint(x: 0.38106*width, y: 1.00431*height), control2: CGPoint(x: 0.32242*width, y: 0.99259*height))
        path.addCurve(to: CGPoint(x: 0.05901*width, y: 0.76733*height), control1: CGPoint(x: 0.16877*width, y: 0.91323*height), control2: CGPoint(x: 0.107*width, y: 0.84695*height))
        path.addCurve(to: CGPoint(x: 0.07152*width, y: 0.74107*height), control1: CGPoint(x: 0.04968*width, y: 0.75184*height), control2: CGPoint(x: 0.05946*width, y: 0.73165*height))
        path.addCurve(to: CGPoint(x: 0.17476*width, y: 0.79948*height), control1: CGPoint(x: 0.10355*width, y: 0.76611*height), control2: CGPoint(x: 0.1403*width, y: 0.79252*height))
        path.addCurve(to: CGPoint(x: 0.00903*width, y: 0.51008*height), control1: CGPoint(x: 0.084*width, y: 0.71497*height), control2: CGPoint(x: 0.03322*width, y: 0.62351*height))
        path.addCurve(to: CGPoint(x: 0.02703*width, y: 0.48993*height), control1: CGPoint(x: 0.00519*width, y: 0.49209*height), control2: CGPoint(x: 0.01747*width, y: 0.47874*height))
        path.addCurve(to: CGPoint(x: 0.11489*width, y: 0.56511*height), control1: CGPoint(x: 0.05344*width, y: 0.52083*height), control2: CGPoint(x: 0.08338*width, y: 0.55346*height))
        path.addCurve(to: CGPoint(x: 0.1216*width, y: 0.05152*height), control1: CGPoint(x: 0.07134*width, y: 0.37091*height), control2: CGPoint(x: 0.0711*width, y: 0.22719*height))
        path.addCurve(to: CGPoint(x: 0.14523*width, y: 0.05625*height), control1: CGPoint(x: 0.12668*width, y: 0.03383*height), control2: CGPoint(x: 0.1425*width, y: 0.03727*height))
        path.closeSubpath()
        return path
    }
}
