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
            action()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .fontWeight(.bold)
                .foregroundStyle(Color(.systemGray3))
        }
        .buttonStyle(PressButtonStyle())
    }
}

#Preview {
    CloseButton {
        print("button clicked")
    }
}
