//
//  StickyHeader.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/27/24.
//

import SwiftUI

struct StickyHeader: ViewModifier {
    var stickyHeaders: [CGRect]
    var isMainHeader: Bool
    var isEmptyHeader: Bool
    
    @State private var frame: CGRect = .zero
    
    private var isSubHeaderSticky: Bool {
        if let mainHeader = stickyHeaders.first {
            return frame.minY < mainHeader.height
        }
        return false
    }
    
    private var mainHeaderOffset: CGFloat {
        guard frame.minY < 0 else { return 0}
        return -frame.minY
    }
    
    private var subHeaderOffset: CGFloat {
        var offset = -frame.minY
        
        guard isSubHeaderSticky else { return 0 }
        guard let mainHeader = stickyHeaders.first else { return 0 }
        offset += mainHeader.height
        return offset
    }
    
    private var opacity: CGFloat {
        var opacity: CGFloat = 1
        
        guard let mainHeader = stickyHeaders.first else { return 1 }
        if let nextHeader = stickyHeaders.first(where: { $0.minY > frame.minY && $0.minY < 40 + mainHeader.height }) {
            withAnimation {
                opacity = max((nextHeader.minY - mainHeader.height)/40, 0)
            }
        }
        return opacity
    }
    
    private var scale: CGFloat {
        var scale: CGFloat = 1
        
        guard let mainHeader = stickyHeaders.first else { return 1 }
        if let nextHeader = stickyHeaders.first(where: { $0.minY > frame.minY && $0.minY < 40 + mainHeader.height }) {
            withAnimation {
                if nextHeader.minY - mainHeader.height >= 0 {
                    withAnimation {
                        scale -= (40 - nextHeader.minY + mainHeader.height) * 0.001
                    }
                }
            }
        }
        return scale
    }
    
    func body(content: Content) -> some View {
        content
            .offset(y: isMainHeader ? mainHeaderOffset : subHeaderOffset)
            .zIndex(isMainHeader ? .infinity : isEmptyHeader ? 2 : 100)
            .overlay(
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .named("container"))
                    Color.clear
                        .onAppear { self.frame = frame }
                        .onChange(of: frame) { self.frame = $1 }
                        .preference(key: StickyHeaderPreferenceKey.self, value: [self.frame])
                }
            )
            .opacity(isMainHeader || isEmptyHeader ? 1 : opacity)
            .scaleEffect(isMainHeader || isEmptyHeader ?  1 : scale, anchor: .top)
    }
}
