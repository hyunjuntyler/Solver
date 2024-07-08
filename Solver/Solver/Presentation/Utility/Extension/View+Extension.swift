//
//  View+Extension.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI

extension View {
    func shimmerEffect(color: Color = .white, opacity: CGFloat = 0.6, duration: CGFloat = 3) -> some View {
        modifier(ShimmerEffect(color: color, opacity: opacity, duration: duration))
    }
    
    func stickyHeader(_ stickyHeaders: [CGRect], isTearHeader: Bool = false, isEmptyHeader: Bool = false) -> some View {
        modifier(StickyHeader(stickyHeaders: stickyHeaders, isTearHeader: isTearHeader, isEmptyHeader: isEmptyHeader))
    }
    
    func summaryBody() -> some View {
        modifier(SummaryBody())
    }
}
