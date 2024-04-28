//
//  Header.swift
//  Solver
//
//  Created by hyunjun on 4/28/24.
//

import SwiftUI

struct Header: View {
    var userStore: UserStore
    var frames: [CGRect]
    
    var body: some View {
        VStack {
            if let user = userStore.user, let headerFrame = frames.first {
                let offset = headerFrame.minY
                var topPadding: CGFloat {
                    return max(min(20 + offset, 20), 5)
                }
                
                var tierBadgeSize: CGFloat {
                    return max(min(140 + offset / 100 * 60, 170), 80)
                }
                
                var tierFontSize: CGFloat {
                    return max(min(28 + offset / 100 * 8, 32), 20)
                }
                
                var idFontSize: CGFloat {
                    return max(min(22 + offset / 100 * 2, 24), 20)
                }
                
                var bodyFontSize: CGFloat {
                    return max(min(17 + offset / 100 * 2, 19), 15)
                }
                
                var badgeSize: CGFloat {
                    return max(min(30 + offset / 100 * 4, 32), 26)
                }
                
                var progressWidth: CGFloat {
                    return max(min(200 + offset / 80 * 50, 225), 150)
                }
                
                VStack {
                    HStack {
                        ProfileImage(data: userStore.profile?.image, size: badgeSize)
                        Text(user.id)
                            .font(.system(size: idFontSize))
                            .fontWeight(.semibold)
                        BadgeImage(data: userStore.badge?.image, size: badgeSize)
                        ClassBadge(userClass: user.userClass, size: badgeSize)
                    }
                    
                    TierBadge(tier: user.tier, size: tierBadgeSize)
                        .shadow(radius: 2)
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
                        .font(.system(size: bodyFontSize))
                        .padding(.top, 2)
                    }
                    
                    let required = userStore.required
                    let next = required[user.tier+1]
                    let current = required[user.tier]
                    let value = (Double(user.rating) - current) / (next - current)
                    
                    ProgressView(value: min(value, 1))
                        .frame(width: progressWidth)
                        .tint(user.tier.tierBadgeColor)
                    
                    HStack {
                        if user.tier < 31 {
                            Text("⛳️")
                                .font(.tossBody)
                            Text("\(Int(next) - user.rating)")
                        }
                        Text("✍️")
                            .font(.tossBody)
                        Text("\(user.solvedCount)")
                        Text("🌱")
                            .font(.tossBody)
                        Text("\(user.maxStreak)")
                    }
                    .font(.system(size: bodyFontSize))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, topPadding)
                .background(LinearGradient(colors: [user.tier.tierBackgroundColor, Color(.systemBackground)], startPoint: .top, endPoint: .bottom))
            }
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

