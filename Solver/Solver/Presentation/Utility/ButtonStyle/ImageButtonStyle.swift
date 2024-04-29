//
//  ImageButtonStyle.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/29/24.
//

import SwiftUI

struct ImageButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .shadow(radius: configuration.isPressed ? 1 : 0)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
