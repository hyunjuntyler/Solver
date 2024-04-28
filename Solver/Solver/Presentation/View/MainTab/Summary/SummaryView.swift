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
    var problemsStore: ProblemsStore
    var top100Store: Top100Store
    
    var body: some View {
        ScrollView {
            VStack(spacing: 0) {
                Header(userStore: userStore, frames: frames)
                    .sticky(frames, isMainHeader: true)
                
                Rectangle()
                    .frame(height: 30)
                    .foregroundStyle(.background)
                    .sticky(frames, isEmptyHeader: true)
                    .padding(.bottom, -30)
                
                HStack {
                    let count = min(problemsStore.solvedCount, 50)
                    
                    Text("🚀")
                        .font(.tossBody)
                    Text("상위 \(count)문제")
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
                .sticky(frames)
                .padding(.top)
                
                Top50(store: top100Store)
                    .padding(.top, 20)
                    .padding()
                    .background {
                        UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                            .foregroundStyle(.ultraThinMaterial)
                    }
                    .padding(.horizontal)
                    .padding(.top, -20)
                
                HStack {
                    Text("📊")
                        .font(.tossBody)
                    Text("난이도 분포")
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
                .sticky(frames)
                
                ProblemsChart(store: problemsStore)
                    .padding(.top, 20)
                    .padding()
                    .background {
                        UnevenRoundedRectangle(bottomLeadingRadius: 16, bottomTrailingRadius: 16, style: .continuous)
                            .foregroundStyle(.ultraThinMaterial)
                    }
                    .padding(.horizontal)
                    .padding(.top, -20)
                
                Rectangle()
                    .frame(height: 40)
                    .foregroundStyle(.clear)
                    .sticky(frames)
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
    return SummaryView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store)
}
