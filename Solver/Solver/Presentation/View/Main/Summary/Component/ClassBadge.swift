//
//  ClassBadge.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

struct ClassBadge: View {
    let userClass: Int
    let size: CGFloat
    
    var body: some View {
        ZStack {
            Rhombus(size: size/2 * sqrt(2), color: userClass.classBadgeColor.out1, degree: .degrees(45))
            Rhombus(size: size/2 * sqrt(2), color: userClass.classBadgeColor.out2, degree: .degrees(-135))
            Rhombus(size: size/2 * sqrt(2) * 0.7, color: userClass.classBadgeColor.in1, degree: .degrees(45))
            Rhombus(size: size/2 * sqrt(2) * 0.7, color: userClass.classBadgeColor.in2, degree: .degrees(-135))

            Text("\(userClass)")
                .fontWeight(.heavy)
                .fontDesign(.monospaced)
                .font(.system(size: size * 0.5))
                .foregroundStyle(.black)
                .brightness(0.2)
                .shadow(color: .white, radius: size/50)
                .shadow(color: .white, radius: size/50)
                .shadow(color: .white, radius: size/50)
                .shadow(color: .white, radius: size/50)
        }
        .frame(width: size, height: size)
    }
}

fileprivate struct Rhombus: View {
    var size: CGFloat
    var color: Color
    var degree: Angle
    
    var body: some View {
        Rectangle()
            .trim(from: 0.25, to: 0.75)
            .scaledToFit()
            .frame(width: size)
            .rotationEffect(degree)
            .foregroundStyle(color)
    }
}

#Preview {
    ClassBadge(userClass: 1, size: 80)
}
