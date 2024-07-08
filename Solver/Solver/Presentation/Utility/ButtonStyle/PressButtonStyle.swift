//
//  PressButtonStyle.swift
//  Solver
//
//  Created by hyunjun on 7/8/24.
//

import SwiftUI

struct PressButtonStyle: ButtonStyle {    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.bouncy(duration: 1), value: configuration.isPressed)
    }
}
