//
//  SummaryView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct SummaryView: View {
    @State private var frames: [CGRect] = []
    var userStore: UserStore
    @ObservedObject var problemsStore: ProblemsStore
    @ObservedObject var top100Store: Top100Store
    
    private var solvedCount: Int {
        min(problemsStore.solvedCount, 50)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                ProfileHeader(userStore: userStore, frames: frames)
                    .stickyHeader(frames, isMainHeader: true)
                
                Rectangle()
                    .frame(height: 30)
                    .foregroundStyle(.background)
                    .stickyHeader(frames, isEmptyHeader: true)
                    .padding(.bottom, -30)
                
                SummaryHeader(emoji: "🚀", title: "내가 푼 상위 \(solvedCount)문제")
                    .stickyHeader(frames)
                    .padding(.top)
                
                Top50Problems(store: top100Store)
                    .summaryBody()
                
                SummaryHeader(emoji: "📊", title: "내가 푼 문제 난이도 분포")
                    .stickyHeader(frames)
                
                ProblemsChart(store: problemsStore)
                    .summaryBody()
                
                Rectangle()
                    .frame(height: 40)
                    .foregroundStyle(.clear)
                    .stickyHeader(frames)
            }
        }
        .scrollIndicators(.hidden)
        .coordinateSpace(name: "container")
        .onPreferenceChange(StickyHeaderPreferenceKey.self) {
            frames = $0.sorted(by: { $0.minY < $1.minY })
        }
        .refreshable {
            userStore.fetch()
            top100Store.fetch()
            problemsStore.fetch()
        }
        .overlay(alignment: .top) {
            if let user = userStore.user {
                user.tier.tierBackgroundColor
                    .ignoresSafeArea()
                    .frame(height: 0)
            }
        }
        .background(alignment: .top) {
            if let user = userStore.user, let first = frames.first {
                user.tier.tierBackgroundColor
                    .frame(height: max(100 + first.minY, 100))
            }
        }
    }
}

#Preview {
    let previewData = PreviewData()
    let userStore = UserStore(user: previewData.users[1], profile: previewData.profile, badge: previewData.badge)
    let problemsStore = ProblemsStore(problems: previewData.problems)
    let top100Store = Top100Store(top100: previewData.top100)
    return ToastWindow { SummaryView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store) }
}
