//
//  SummaryView.swift
//  Solver
//
//  Created by hyunjun on 4/25/24.
//

import SwiftUI

struct SummaryView: View {
    var userStore: UserStore
    var problemsStore: ProblemsStore
    var top100Store: Top100Store
    
    @State private var offset: CGPoint = .zero
    
    var body: some View {
        ScrollView {
            Color.clear.frame(height: 0)
                .onScrollOffsetChanged { offset in
                    self.offset = offset
                }
            if let user = userStore.user {
                VStack {
                    HStack {
                        ProfileImage(data: userStore.profile?.image, size: 56)
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
                .zIndex(1)
                .offset(y: offset.y > 59 ? 0 : -offset.y + 59)
            }
            
            Top30(store: top100Store)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundStyle(.ultraThinMaterial)
                }
                .padding()
            ProblemsChart(store: problemsStore)
                .padding()
                .background {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .foregroundStyle(.ultraThinMaterial)
                }
                .padding(.horizontal)
        }
        .overlay {
            Text("\(offset.y)")
        }
        .refreshable {
            
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
