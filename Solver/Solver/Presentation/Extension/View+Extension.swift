//
//  View+Extension.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI

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
    
    func shimmer(color: Color = .white, opacity: CGFloat = 0.6, duration: CGFloat = 3) -> some View {
        self
            .modifier(ShimmerEffect(color: color, opacity: opacity, duration: duration))
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero
    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
        value = nextValue()
    }
}

struct ShimmerEffect: ViewModifier {
    @State private var start = UnitPoint(x: -1.8, y: -1.2)
    @State private var end = UnitPoint(x: 0, y: -0.2)
    
    var color: Color
    var opacity: CGFloat
    var duration: CGFloat
    
    func body(content: Content) -> some View {
        content
            .overlay {
                Rectangle()
                    .mask(content)
                    .foregroundStyle(
                        LinearGradient(colors:
                                        [color.opacity(0),
                                         color.opacity(opacity/4),
                                         color.opacity(opacity/2),
                                         color.opacity(opacity),
                                         color.opacity(opacity/2),
                                         color.opacity(opacity/4),
                                         color.opacity(0)
                                        ],
                                       startPoint: start,
                                       endPoint: end))
                    .onAppear {
                        withAnimation(.easeInOut(duration: duration).repeatForever(autoreverses: false)) {
                            start = UnitPoint(x: 1, y: 1)
                            end = UnitPoint(x: 2.2, y: 2.2)
                        }
                    }
            }
    }
}
