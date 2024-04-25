//
//  SummaryView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct SummaryView: View {
    var store: MainTabStore
    
    var body: some View {
        VStack {
            if let image = store.profileImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100)
            }
            Text(store.userId)
            Text("\(store.rankRatio ?? -1)")
            Text("\(store.solvedCount ?? -1)")
            Text("\(store.problemCount ?? -1)")
            Text("\(store.top100Count ?? -1)")
        }
    }
}

#Preview {
    SummaryView(store: MainTabStore(preview: true))
}
