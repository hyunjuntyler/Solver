//
//  StickyHeader.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/27/24.
//

import SwiftUI

struct StickyHeader: ViewModifier {
    var stickyHeaders: [CGRect]
    var isTearHeader: Bool
    var isEmptyHeader: Bool
    
    @State private var frame: CGRect = .zero
    
    private var isSubHeaderSticky: Bool {
        guard let mainHeader = stickyHeaders.first else { return false }
        return frame.minY < mainHeader.height
    }
    
    private var mainHeaderOffset: CGFloat {
        return frame.minY < 0 ? -frame.minY : 0
    }
    
    private var subHeaderOffset: CGFloat {
        guard isSubHeaderSticky, let mainHeader = stickyHeaders.first else { return 0 }
        return -frame.minY + mainHeader.height
    }
    
    private var opacity: CGFloat {
        guard let mainHeader = stickyHeaders.first, mainHeader.height <= 125 else { return 1 }
        guard let nextHeader = stickyHeaders.first(where: { $0.minY > frame.minY && $0.minY < 40 + mainHeader.height }) else { return 1 }
        return max((nextHeader.minY - mainHeader.height) / 40, 0)
    }
    
    private var scale: CGFloat {
        guard let mainHeader = stickyHeaders.first else { return 1 }
        guard let nextHeader = stickyHeaders.first(where: { $0.minY > frame.minY && $0.minY < 40 + mainHeader.height }) else { return 1 }
        guard nextHeader.minY - mainHeader.height >= 0 && mainHeader.height < 200 else { return 1 }
        return 1 - (40 - nextHeader.minY + mainHeader.height) * 0.001
    }
    
    func body(content: Content) -> some View {
        content
            .offset(y: isTearHeader ? mainHeaderOffset : subHeaderOffset)
            .zIndex(isTearHeader ? .infinity : isEmptyHeader ? 2 : 100)
            .overlay(
                GeometryReader { proxy in
                    let frame = proxy.frame(in: .named("container"))
                    Color.clear
                        .onAppear { self.frame = frame }
                        .onChange(of: frame) { self.frame = $1 }
                        .preference(key: StickyHeaderPreferenceKey.self, value: [self.frame])
                }
            )
            .scaleEffect(isTearHeader || isEmptyHeader ?  1 : scale, anchor: .top)
            .opacity(isTearHeader || isEmptyHeader ? 1 : opacity)
    }
}
