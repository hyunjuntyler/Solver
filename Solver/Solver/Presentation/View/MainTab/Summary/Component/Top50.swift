//
//  Top50.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI

struct Top50: View {
    var store: Top100Store
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 10)
    private let spacing: CGFloat = 16
    private let size: CGFloat = 24
    
    var body: some View {
        if let top100 = store.top100 {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(top100.items.prefix(50)) { item in
                    TierBadge(tier: item.level, size: size)
                }
            }
        }
    }
}

#Preview {
    let previewData = PreviewData()
    let store = Top100Store(top100: previewData.top100)
    return Top50(store: store)
}
