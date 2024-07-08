//
//  ProblemsChart.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI
import Charts

struct ProblemsChart: View {
    @ObservedObject var store: ProblemsStore
    
    var body: some View {
        if !store.problemsStats.isEmpty {
            VStack(alignment: .leading) {
                VStack {
                    PieChart
                    Legend
                }
                .onTapGesture {
                    withAnimation(.bouncy(duration: 0.8)) {
                        store.selectedStats = nil
                    }
                }
            }
        } else {
            ProgressView()
                .controlSize(.large)
                .frame(maxWidth: .infinity)
                .frame(height: 420)
        }
    }
    
    var PieChart: some View {
        Chart(store.problemsStats, id: \.tier) { stats in
            SectorMark(
                angle: .value("Solved count", stats.count),
                innerRadius: .ratio(0.6),
                outerRadius: store.selectedStats?.tier == stats.tier ? 150 : 120,
                angularInset: 1
            )
            .foregroundStyle(stats.color)
            .cornerRadius(6)
        }
        .chartAngleSelection(value: $store.selection)
        .chartBackground { proxy in
            if let stats = store.selectedStats {
                VStack {
                    Text(stats.tier)
                        .foregroundStyle(stats.color)
                        .fontWeight(.semibold)
                    Text("\(stats.count) 문제")
                        .fontWeight(.bold)
                        .font(.title3)
                        .contentTransition(.numericText())
                }
                .transition(.scale)
            } else {
                VStack {
                    Text("전체")
                        .fontWeight(.semibold)
                    Text("\(store.solvedCount) 문제")
                        .fontWeight(.bold)
                        .font(.title3)
                }
            }
        }
        .onChange(of: store.selection) {
            if let value = $1 {
                withAnimation(.bouncy(duration: 0.8)) {
                    store.getSelectedStats(value)
                }
            }
        }
        .onChange(of: store.selectedStats) {
            Haptic.impact(style: .soft)
        }
        .frame(height: 260)
        .padding(.vertical)
    }
    
    var Legend: some View {
        VStack(alignment: .leading) {
            ForEach(store.problemsStats, id: \.tier) { stats in
                HStack {
                    Text(stats.tier)
                        .foregroundStyle(stats.color)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("\(stats.count)")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text("\(stats.count.toPercentile(by: store.solvedCount)) %")
                        .foregroundStyle(.gray)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    let previewData = PreviewData()
    let store = ProblemsStore(problems: previewData.problems)
    return ProblemsChart(store: store)
        .padding()
        .background {
            UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.horizontal)
}

#Preview("ContentUnavailable") {
    let store = ProblemsStore()
    return ProblemsChart(store: store)
        .padding()
        .background {
            UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.horizontal)
}
