//
//  CustomButtonStyle.swift
//  Solver
//
//  Created by hyunjun on 4/28/24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    var style: ButtonType
    var disable: Bool = false
    
    private var labelColor: Color {
        switch style {
        case .singUp: .white
        case .changeId: .primary
        }
    }
    
    private var buttonColor: Color {
        switch style {
        case .singUp: .accentColor
        case .changeId: Color(.systemGray5)
        }
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(disable ? .gray : labelColor)
            .bold()
            .padding()
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .foregroundStyle(disable ? Color(.systemGray5) : buttonColor)
            }
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.bouncy, value: configuration.isPressed)
            .animation(.bouncy, value: disable)
    }
}
