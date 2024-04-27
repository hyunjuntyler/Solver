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
                if let user = userStore.user {
                    VStack {
                        HStack {
                            ProfileImage(data: userStore.profile?.image, size: 40)
                            Text(user.id)
                                .font(.title3)
                            BadgeImage(data: userStore.badge?.image, size: 24)
                            ClassBadge(userClass: user.userClass, size: 24)
                        }
                        
                        VStack {
                            HStack {
                                Text("✍️")
                                    .font(.tossBody)
                                Text("\(user.solvedCount)")
                                Text("🌱")
                                    .font(.tossBody)
                                Text("\(user.maxStreak)")
                            }
                            
                            TierBadge(tier: user.tier, size: 100)
                                .shimmer()
                            
                            HStack {
                                Text(user.tier.tierName)
                                Text("\(user.rating)")
                            }
                            .foregroundStyle(user.tier.tierBadgeColor)
                            .font(.title2)
                            .fontWeight(.semibold)
                            
                            if let count = userStore.userCount {
                                HStack {
                                    Text("랭킹 \(user.rank)위")
                                    Text("(상위 \(user.rank.toPercentile(by: count))%)")
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemBackground))
                    .sticky(frames, isMainHeader: true)
                }
                
                Rectangle()
                    .frame(height: 30)
                    .foregroundStyle(.background)
                    .sticky(frames, isEmptyHeader: true)
                    .padding(.bottom, -30)
                
                HStack {
                    Text("🚀")
                        .font(.tossBody)
                    Text("상위 30문제")
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
                
                Top30(store: top100Store)
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
            Color(.systemBackground)
                .ignoresSafeArea()
                .frame(height: 0)
        }
    }
}

#Preview {
    let previewData = PreviewData()
    let userStore = UserStore(user: previewData.users[0], profile: previewData.profile, badge: previewData.badge)
    let problemsStore = ProblemsStore(problems: previewData.problems)
    let top100Store = Top100Store(top100: previewData.top100)
    return SummaryView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store)
}
