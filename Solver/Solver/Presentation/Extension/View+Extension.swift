//
//  View+Extension.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

extension View {
    func onScrollOffsetChanged(action: @escaping (_ offset: CGPoint) -> Void) -> some View {
        self
            .background(GeometryReader { geometry in
                Color.clear
                    .preference (
                        key: ScrollOffsetPreferenceKey.self,
                        value: geometry.frame(in: .global).origin
                    )
            })
            .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: action)
    }
}
