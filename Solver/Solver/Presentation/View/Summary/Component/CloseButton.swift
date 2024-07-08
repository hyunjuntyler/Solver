//
//  CloseButton.swift
//  Solver
//
//  Created by hyunjun on 7/8/24.
//

import SwiftUI

struct CloseButton: View {
    let action: () -> Void
    
    var body: some View {
        Button {
            Haptic.impact(style: .soft)
            action()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(Color(.systemGray2))
        }
        .buttonStyle(PressButtonStyle())
    }
}

#Preview {
    CloseButton {
        print("button clicked")
    }
}
