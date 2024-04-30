//
//  ProfileHeader.swift
//  Solver
//
//  Created by hyunjun on 4/28/24.
//

import SwiftUI

struct ProfileHeader: View {
    var userStore: UserStore
    var frames: [CGRect]
    
    private var offset: CGFloat? {
        frames.first?.minY
    }
    
    var body: some View {
        VStack {
            if let user = userStore.user, let offset {
                VStack {
                    HStack {
                        ProfileImage(data: userStore.profile?.image, size: max(min(30 + offset / 100 * 4, 32), 26))
                        Text(user.id)
                            .font(.system(size: max(min(22 + offset / 100 * 2, 24), 20)))
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                        
                        Button {
                            Haptic.impact(style: .soft)
                            if let badge = userStore.badge {
                                Toast.shared.present(data: badge.image, title: badge.name, body: badge.description)
                            }
                        } label: {
                            BadgeImage(data: userStore.badge?.image, size: max(min(30 + offset / 100 * 4, 32), 26))
                        }
                        .buttonStyle(ImageButtonStyle())
                        
                        Button {
                            Haptic.impact(style: .soft)
                        } label: {
                            ClassBadge(userClass: user.userClass, size: max(min(30 + offset / 100 * 4, 32), 26))
                        }
                        .buttonStyle(ImageButtonStyle())
                    }
                    
                    Button {
                        Haptic.impact(style: .soft)
                    } label: {
                        VStack(spacing: 6) {
                            TierBadge(tier: user.tier, size: max(min(140 + offset / 100 * 60, 170), 80))
                                .shadow(radius: 4)
                            HStack {
                                Text(user.tier.tierName)
                                Text("\(user.rating)")
                            }
                            .foregroundStyle(user.tier.tierBadgeColor)
                            .font(.system(size: max(min(28 + offset / 100 * 8, 32), 20)))
                            .fontWeight(.bold)
                        }
                            .shimmerEffect()
                    }
                    .buttonStyle(ProfileButtonStyle(color: user.tier.tierColor))
                    
                    if let count = userStore.userCount {
                        HStack {
                            Text("랭킹 \(user.rank)위")
                                .fontWeight(.semibold)
                            Text("(상위 \(user.rank.toPercentile(by: count))%)")
                        }
                        .font(.system(size: max(min(17 + offset / 100 * 2, 19), 15)))
                        .padding(.top, 2)
                    }
                    
                    TierProgress(tier: user.tier, rating: user.rating)
                        .frame(width: max(min(210 + offset / 80 * 60, 240), 150))
                        .tint(user.tier.tierBadgeColor)
                    
                    HStack(spacing: 12) {
                        if user.tier < 31 {
                            let requiredRating = Int(userStore.required[user.tier+1]) - user.rating
                            
                            Button {
                                Haptic.impact(style: .soft)
                                Toast.shared.present(symbol: "🎯", title: "\((user.tier + 1).tierName) 승급까지 남은 점수", body: "\(requiredRating)점")
                            } label: {
                                HStack {
                                    Text("🎯")
                                        .font(.tossBody)
                                    Text("\(requiredRating)")
                                }
                            }
                            .buttonStyle(ComponentButtonStyle())
                        }
                        
                        Button {
                            Haptic.impact(style: .soft)
                            Toast.shared.present(symbol: "✍️", title: "지금까지 해결한 문제", body: "\(user.solvedCount)문제")
                        } label: {
                            HStack {
                                Text("✍️")
                                    .font(.tossBody)
                                Text("\(user.solvedCount)")
                            }
                        }
                        .buttonStyle(ComponentButtonStyle())
                        
                        Button {
                            Haptic.impact(style: .soft)
                            Toast.shared.present(symbol: "🌱", title: "최대 연속 문제풀이 일수", body: "\(user.maxStreak)일")
                        } label: {
                            HStack {
                                Text("🌱")
                                    .font(.tossBody)
                                Text("\(user.maxStreak)")
                            }
                        }
                        .buttonStyle(ComponentButtonStyle())
                    }
                    .font(.system(size: max(min(17 + offset / 100 * 2, 19), 15)))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, max(min(20 + offset, 20), 5))
                .background(LinearGradient(colors: [user.tier.tierBackgroundColor, Color(.systemBackground)], startPoint: .top, endPoint: .bottom))
            } else {
                ProgressView()
                    .controlSize(.large)
                    .frame(height: 360)
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

#Preview("ContentUnavailable") {
    ProgressView()
        .controlSize(.large)
        .frame(height: 360)
}
