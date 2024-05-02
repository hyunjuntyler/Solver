//
//  MediumWidget.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/29/24.
//

import WidgetKit
import SwiftUI

struct MediumWidget: View {
    var user: User
    
    var body: some View {
        VStack {
            HStack {
                ProfileImage(data: user.profile?.image, size: 24)
                Text(user.id)
                    .fontWeight(.semibold)
                BadgeImage(data: user.badge?.image, size: 24)
                ClassBadge(userClass: user.userClass, size: 24)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(alignment: .top) {
                TierBadge(tier: user.tier, size: 60)
                    .shadow(radius: 0.5)
                    .padding(.trailing)
                    .offset(y: 6)

                VStack(alignment: .leading, spacing: 8) {
                    HStack {
                        HStack {
                            Text(user.tier.tierName)
                            Text(String(user.rating))
                        }
                        .foregroundStyle(user.tier.tierColor)
                        .fontWeight(.bold)
                        .font(.headline)
                        
                        HStack {
                            Text("랭킹 \(user.rank)위")
                        }
                        .foregroundStyle(.secondary)
                        .font(.caption2)
                    }
                    
                    HStack(spacing: 0) {
                        Text("✍️ ")
                            .font(.tossCaption)
                        Text("총 ")
                        Text("\(user.solvedCount)")
                            .fontWeight(.semibold)
                        Text("문제 해결")
                    }
                    .font(.caption)
                    
                    HStack(spacing: 0) {
                        Text("🌱 ")
                            .font(.tossCaption)
                        Text("최대 ")
                        Text("\(user.maxStreak)")
                            .fontWeight(.semibold)
                        Text("일 연속 문제 해결")
                    }
                    .font(.caption)
                }
            }
            .frame(height: 76)
            
            TierProgress(tier: user.tier, rating: user.rating)
                .tint(user.tier.tierBadgeColor)
                .padding(.horizontal)
        }
        .containerBackground(LinearGradient(colors: [user.tier.tierBackgroundColor, Color(.tertiarySystemBackground)], startPoint: .top, endPoint: .bottom), for: .widget)
    }
}
