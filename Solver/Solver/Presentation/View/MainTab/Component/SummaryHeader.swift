//
//  SummaryHeader.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/29/24.
//

import SwiftUI

struct SummaryHeader: View {
    var emoji: String
    var title: String
    
    var body: some View {
        HStack {            
            Text(emoji)
                .font(.tossBody)
            Text(title)
                .foregroundStyle(.secondary)
                .fontWeight(.medium)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 40)
        .padding(.horizontal)
        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundStyle(.ultraThinMaterial)
        }
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview {
    SummaryHeader(emoji: "🚀", title: "상위 50문제")
}
