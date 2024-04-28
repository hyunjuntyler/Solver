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
                if let user = userStore.user, let headerFrame = frames.first {
                    let offset = headerFrame.minY
                    var topPadding: CGFloat {
                        return max(min(20 + offset, 20), 0)
                    }
                    
                    var tierBadgeSize: CGFloat {
                        return max(min(140 + offset, 180), 60)
                    }
                    
                    var tierFontSize: CGFloat {
                        return max(min(28 + offset/10, 32), 20)
                    }
                    
                    VStack {
                        HStack {
                            ProfileImage(data: userStore.profile?.image, size: 40)
                            Text(user.id)
                                .font(.title2)
                            BadgeImage(data: userStore.badge?.image, size: 30)
                            ClassBadge(userClass: user.userClass, size: 30)
                        }
                        
                        HStack {
                            Text("✍️")
                                .font(.tossBody)
                            Text("\(user.solvedCount)")
                            Text("🌱")
                                .font(.tossBody)
                            Text("\(user.maxStreak)")
                        }
                        
                        TierBadge(tier: user.tier, size: tierBadgeSize)
                            .shimmer()
                        
                        HStack {
                            Text(user.tier.tierName)
                            Text("\(user.rating)")
                        }
                        .foregroundStyle(user.tier.tierBadgeColor)
                        .font(.system(size: tierFontSize))
                        .fontWeight(.semibold)
                        .shimmer()
                        
                        if let count = userStore.userCount {
                            HStack {
                                Text("랭킹 \(user.rank)위")
                                    .fontWeight(.semibold)
                                Text("(상위 \(user.rank.toPercentile(by: count))%)")
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, topPadding)
                    .background(Color(.systemBackground))
                    .sticky(frames, isMainHeader: true)
//                    .overlay {
//                        Text("\(offset)")
//                    }
                }
                
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
