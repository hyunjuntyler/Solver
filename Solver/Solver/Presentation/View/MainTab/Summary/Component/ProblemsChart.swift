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
    
    var body: some View {
        VStack(alignment: .leading) {
            Title
            
            HStack {
                PieChart
                Legend
            }
            .frame(height: 122)
        }
    }
    
    var Title: some View {
        HStack(spacing: 0) {
            Text("\(store.solvedCount)")
                .fontWeight(.bold)
            Text("문제 해결")
        }
    }
    
    var PieChart: some View {
        Chart(store.problemsStats, id: \.tier) { stats in
            SectorMark(
                angle: .value("Solved count", stats.count),
                innerRadius: .ratio(0.4),
                outerRadius: 120
            )
            .foregroundStyle(stats.color)
        }
    }
    
    var Legend: some View {
        VStack(alignment: .leading) {
            ForEach(store.problemsStats, id: \.tier) { stats in
                HStack {
                    Text(stats.tier)
                        .foregroundStyle(stats.color)
                        .fontWeight(.semibold)
                        .frame(width: 64, alignment: .leading)
                    Text("\(stats.count)")
                            .fontWeight(.semibold)
                            .frame(width: 40, alignment: .leading)
                    HStack(spacing: 2) {
                        stats.count.toPercentile(by: store.solvedCount)
                        Text("%")
                    }
                    .foregroundStyle(.gray)
                }
                .font(.footnote)
            }
        }
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    let previewData = PreviewData()
    let store = ProblemsStore(problems: previewData.problems)
    return ProblemsChart(store: store)
}
