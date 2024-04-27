//
//  ProblemsChart.swift
//  Solver
//
//  Created by hyunjun on 4/27/24.
//

import SwiftUI
import Charts

struct ProblemsChart: View {
    var store: ProblemsStore
    
    @State private var selection: Int?
    @State private var selectedStats: ProblemStats?
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack {
                PieChart
                Legend
            }
            .onTapGesture {
                withAnimation(.bouncy(duration: 0.8)) {
                    selectedStats = nil
                }
            }
        }
    }
    
    var PieChart: some View {
        Chart(store.problemsStats, id: \.tier) { stats in
            SectorMark(
                angle: .value("Solved count", stats.count),
                innerRadius: .ratio(0.6),
                outerRadius: selectedStats?.tier == stats.tier ? 145 : 120,
                angularInset: 1
            )
            .foregroundStyle(stats.color)
            .cornerRadius(4)
        }
        .chartAngleSelection(value: $selection)
        .chartBackground { proxy in
            if let stats = selectedStats {
                VStack {
                    Text(stats.tier)
                        .foregroundStyle(stats.color)
                        .fontWeight(.semibold)
                    Text("\(stats.count) 문제")
                        .fontWeight(.bold)
                        .font(.title3)
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
        .onChange(of: selection) {
            if let value = $1 {
                withAnimation(.bouncy(duration: 0.8)) {
                    getSelectedStats(value)
                }
            }
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
    
    private func getSelectedStats(_ value: Int) {
        var total = 0
        for stats in store.problemsStats {
            total += stats.count
            if value <= total {
                selectedStats = stats
                break
            }
        }
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
