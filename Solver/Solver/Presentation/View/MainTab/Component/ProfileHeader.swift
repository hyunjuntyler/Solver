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
    
    var body: some View {
        VStack {
            if let user = userStore.user, let headerFrame = frames.first {
                let offset = headerFrame.minY
                
                var topPadding: CGFloat {
                    max(min(20 + offset, 20), 5)
                }
                
                var tierBadgeSize: CGFloat {
                    max(min(140 + offset / 100 * 60, 170), 80)
                }
                
                var tierFontSize: CGFloat {
                    max(min(28 + offset / 100 * 8, 32), 20)
                }
                
                var idFontSize: CGFloat {
                    max(min(22 + offset / 100 * 2, 24), 20)
                }
                
                var bodyFontSize: CGFloat {
                    max(min(17 + offset / 100 * 2, 19), 15)
                }
                
                var badgeSize: CGFloat {
                    max(min(30 + offset / 100 * 4, 32), 26)
                }
                
                var progressWidth: CGFloat {
                    max(min(200 + offset / 80 * 50, 225), 150)
                }
                
                VStack {
                    HStack {
                        ProfileImage(data: userStore.profile?.image, size: badgeSize)
                        Text(user.id)
                            .font(.system(size: idFontSize))
                            .fontWeight(.semibold)
                        
                        Button {
                            Haptic.impact(style: .soft)
                        } label: {
                            BadgeImage(data: userStore.badge?.image, size: badgeSize)
                        }
                        .buttonStyle(ImageButtonStyle())
                        
                        Button {
                            Haptic.impact(style: .soft)
                        } label: {
                            ClassBadge(userClass: user.userClass, size: badgeSize)
                        }
                        .buttonStyle(ImageButtonStyle())
                    }
                    
                    Button {
                        Haptic.impact(style: .soft)
                    } label: {
                        VStack(spacing: 6) {
                            TierBadge(tier: user.tier, size: tierBadgeSize)
                            HStack {
                                Text(user.tier.tierName)
                                Text("\(user.rating)")
                            }
                            .foregroundStyle(user.tier.tierBadgeColor)
                            .font(.system(size: tierFontSize))
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
                        .font(.system(size: bodyFontSize))
                        .padding(.top, 2)
                    }
                    
                    TierProgress(tier: user.tier, rating: user.rating)
                        .frame(width: progressWidth)
                        .tint(user.tier.tierBadgeColor)
                    
                    HStack(spacing: 12) {
                        if user.tier < 31 {
                            Button {
                                Haptic.impact(style: .soft)
                            } label: {
                                HStack {
                                    Text("⛳️")
                                        .font(.tossBody)
                                    Text("\(Int(userStore.required[user.tier+1]) - user.rating)")
                                }
                            }
                            .buttonStyle(ComponentButtonStyle())
                        }
                        
                        Button {
                            Haptic.impact(style: .soft)
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
                        } label: {
                            HStack {
                                Text("🌱")
                                    .font(.tossBody)
                                Text("\(user.maxStreak)")
                            }
                        }
                        .buttonStyle(ComponentButtonStyle())
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
    let userStore = UserStore(user: previewData.users[1], profile: previewData.profile, badge: previewData.badge)
    let problemsStore = ProblemsStore(problems: previewData.problems)
    let top100Store = Top100Store(top100: previewData.top100)
    return SummaryView(userStore: userStore, problemsStore: problemsStore, top100Store: top100Store)
}

