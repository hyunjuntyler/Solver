//
//  Summary.swift
//  Solver
//
//  Created by hyunjun on 7/7/24.
//

import SwiftUI

struct Summary: View {
    let rank: Int
    let rating: Int
    let tier: Int
    let solvedCount: Int
    let maxStreak: Int
    
    private let required: [Int] = [0, 30, 60, 90, 120, 150, 200, 300, 400, 500, 650, 800, 950, 1100, 1250, 1400, 1600, 1750, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2850, 2900, 2950, 3000, 3001]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack(spacing: 0) {
                Text("🏆  ")
                    .font(.tossTitle3)
                Text("랭킹 ")
                Text("\(rank)")
                    .bold()
                Text("위 ")
                Text("(상위 \(rank.toPercentile(by: 130000))%)")
                    .foregroundStyle(.gray)
                    .font(.subheadline)
            }
            
            HStack(spacing: 0) {
                Text("🎯  ")
                    .font(.tossTitle3)
                Text("\((tier + 1).tierName) ")
                    .foregroundStyle((tier + 1).tierColor)
                    .bold()
                Text("승급까지 남은 점수 ")
                Text("\(required[tier + 1] - rating)")
                    .bold()
                Text("점")
            }
            
            HStack(spacing: 0) {
                Text("✍️  ")
                    .font(.tossTitle3)
                Text("지금까지 해결한 문제 ")
                Text("\(solvedCount)")
                    .bold()
                Text("문제")
            }
            
            HStack(spacing: 0) {
                Text("🌱  ")
                    .font(.tossTitle3)
                Text("최대 연속 문제풀이 일수 ")
                Text("\(maxStreak)")
                    .bold()
                Text("일")
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    Summary(rank: 15, rating: 234, tier: 8, solvedCount: 200, maxStreak: 50)
        .padding()
        .background {
            UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.horizontal)
}

