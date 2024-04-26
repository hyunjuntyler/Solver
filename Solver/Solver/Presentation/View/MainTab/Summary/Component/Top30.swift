//
//  Top30.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI

struct Top30: View {
    var store: Top100Store
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 10)
    private let spacing: CGFloat = 16
    private let size: CGFloat = 30
    
    var body: some View {
        if let top100 = store.top100 {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(0..<10) { _ in
                    ForEach(top100.items.prefix(30)) { item in
                        TierBadge(tier: item.level, size: size)
                    }
                }
            }
            .frame(height: size * 3 + spacing * 2, alignment: .top)
        }
    }
}

#Preview {
    let previewData = PreviewData()
    let store = Top100Store(top100: previewData.top100)
    return Top30(store: store)
}
