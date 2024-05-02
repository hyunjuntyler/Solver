//
//  SummaryBody.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/29/24.
//

import SwiftUI

struct SummaryBody: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.top, 20)
            .padding()
            .background {
                UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                    .foregroundStyle(.ultraThinMaterial)
            }
            .padding(.horizontal)
            .padding(.top, -20)
    }
}

