//
//  Top100Problems.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI

struct Top100Problems: View {
    @ObservedObject var store: Top100Store
        
    private let columns = Array(repeating: GridItem(.flexible()), count: 10)
    
    var body: some View {
        if let top100 = store.top100 {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(top100.items, id: \.id) { item in
                    TierBadge(tier: item.level, size: 24)
                        .onTapGesture {
                            withAnimation {
                                if store.selectedItem?.id == item.id {
                                    store.selectedItem = nil
                                } else {
                                    Haptic.impact(style: .soft)
                                    store.selectedItem = item
                                }
                            }
                        }
                        .padding(5)
                        .background {
                            if store.selectedItem?.id == item.id {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .foregroundStyle(item.level.tierColor.opacity(0.2))
                            }
                        }
                }
            }
        } else {
            ProgressView()
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .frame(height: 160)
        }
    }
}

#Preview {
    let previewData = PreviewData()
    let store = Top100Store(top100: previewData.top100)
    return Top100Problems(store: store)
        .padding()
        .background {
            UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.horizontal)
}

#Preview("ContentUnavailable") {
    let store = Top100Store()
    return Top100Problems(store: store)
        .padding()
        .background {
            UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.horizontal)
}
