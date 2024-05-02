//
//  TierProgress.swift
//  Solver
//
//  Created by hyunjun on 4/29/24.
//

import SwiftUI

struct TierProgress: View {
    var tier: Int
    var rating: Int
    
    private let required: [Double] = [0, 30, 60, 90, 120, 150, 200, 300, 400, 500, 650, 800, 950, 1100, 1250, 1400, 1600, 1750, 1900, 2000, 2100, 2200, 2300, 2400, 2500, 2600, 2700, 2800, 2850, 2900, 2950, 3000, 3000.1]
    
    private var next: Double {
        required[tier+1]
    }
    
    private var current: Double {
        required[tier]
    }

    private var value: Double {
        (Double(rating) - current) / (next - current)
    }
    
    var body: some View {
        ProgressView(value: min(value, 1))
    }
}

#Preview {
    return TierProgress(tier: 5, rating: 160)
}
