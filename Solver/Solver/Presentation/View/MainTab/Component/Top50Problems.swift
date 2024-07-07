//
//  Top50Problems.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI

struct Top50Problems: View {
    @ObservedObject var store: Top100Store
    
    @State private var selectedItem: ItemEntity?
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 10)
    private let spacing: CGFloat = 16
    private let size: CGFloat = 24
    
    var body: some View {
        if let top100 = store.top100 {
            LazyVGrid(columns: columns, spacing: spacing) {
                ForEach(top100.items.prefix(50), id: \.id) { item in
                    TierBadge(tier: item.level, size: size)
                        .onTapGesture {
                            withAnimation {
                                if selectedItem?.id == item.id {
                                    selectedItem = nil
                                } else {
                                    Haptic.impact(style: .soft)
                                    selectedItem = item
                                }
                            }
                        }
                        .padding(5)
                        .background {
                            if selectedItem?.id == item.id {
                                RoundedRectangle(cornerRadius: 6, style: .continuous)
                                    .foregroundStyle(item.level.tierColor.opacity(0.2))
                            }
                        }
                }
            }
            .onChange(of: store.isFetching) {
                selectedItem = nil
            }
            .overlay {
                if let item = selectedItem {
                    VStack {
                        HStack {
                            TierBadge(tier: item.level, size: 18)
                                .offset(y: 1)
                            Text(String(item.id))
                                .fontWeight(.semibold)
                                .fontDesign(.monospaced)
                                .contentTransition(.numericText())
                        }
                        Text("\(item.title)")
                            .font(.caption)
                    }
                    .padding(12)
                    .background {
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .foregroundStyle(.ultraThinMaterial)
                    }
                    .transition(.opacity)
                    .onTapGesture {
                        withAnimation(.smooth) {
                            selectedItem = nil
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
    return Top50Problems(store: store)
        .padding()
        .background {
            UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.horizontal)
}

#Preview("ContentUnavailable") {
    let store = Top100Store()
    return Top50Problems(store: store)
        .padding()
        .background {
            UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.horizontal)
}
