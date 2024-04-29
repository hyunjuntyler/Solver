//
//  ProfileButtonStyle.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/29/24.
//

import SwiftUI

struct ProfileButtonStyle: ButtonStyle {
    var color: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .shadow(color: color, radius: configuration.isPressed ? 12 : 0)
            .animation(.bouncy(duration: 1), value: configuration.isPressed)
    }
}
