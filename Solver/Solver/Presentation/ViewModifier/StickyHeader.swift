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
//        if let nextHeader = stickyHeaders.first(where: { $0.minY > frame.minY && $0.minY < frame.height + mainHeader.height }) {
//            offset -= frame.height + mainHeader.height - nextHeader.minY
//        }
        return offset
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
    }
}
