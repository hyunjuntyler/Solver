//
//  ComponentButtonStyle.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/29/24.
//

import SwiftUI

struct ComponentButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(4)
            .background {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .foregroundStyle(Color(.systemGray5))
                    .opacity(configuration.isPressed ? 1 : 0.4)
            }
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut, value: configuration.isPressed)
    }
}
