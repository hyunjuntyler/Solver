//
//  ClassBadge.swift
//  Solver
//
//  Created by hyunjun on 4/26/24.
//

import SwiftUI

struct ClassBadge: View {
    var userClass: Int
    var size: CGFloat
    
    var body: some View {
        ZStack {
            Rectangle()
                .scaledToFit()
                .frame(width: size/2 * sqrt(2))
                .rotationEffect(.degrees(45))
                .frame(width: size, height: size)
            Rectangle()
                .scaledToFit()
                .frame(width: size/2 * sqrt(2) * 0.7)
                .rotationEffect(.degrees(45))
                .foregroundStyle(.gray)
                .frame(width: size, height: size)
            Text("\(userClass)")
                .fontWeight(.heavy)
                .fontDesign(.monospaced)
                .font(.system(size: size * 0.5))
                .foregroundStyle(.black)
                .brightness(0.2)
                .shadow(color: .white, radius: size/25)
        }
    }
}

#Preview {
    ClassBadge(userClass: 1, size: 100)
}
