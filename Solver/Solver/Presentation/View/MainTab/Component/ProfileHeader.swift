//
//  ProfileHeader.swift
//  Solver
//
//  Created by hyunjun on 4/28/24.
//

import SwiftUI

struct ProfileHeader: View {
    let tier: Int
    let rating: Int
    var frames: [CGRect]
    
    private var offset: CGFloat {
        frames.first?.minY ?? 0
    }
    
    var body: some View {
        VStack {
            Button {
                Haptic.impact(style: .soft)
            } label: {
                VStack(spacing: 6) {
                    TierBadge(tier: tier, size: max(min(140 + offset / 100 * 60, 170), 80))
                        .shadow(radius: 4)
                    
                    HStack {
                        Text(tier.tierName)
                        Text("\(rating)")
                    }
                    .foregroundStyle(tier.tierBadgeColor)
                    .font(.system(size: max(min(28 + offset / 100 * 8, 32), 20)))
                    .fontWeight(.bold)
                    
                    TierProgress(tier: tier, rating: rating)
                        .frame(width: max(min(140 + offset / 100 * 60, 170), 80))
                        .tint(tier.tierBadgeColor)
                }
                .shimmerEffect()
            }
            .buttonStyle(ProfileButtonStyle(color: tier.tierColor))
        }
        .frame(maxWidth: .infinity)
        .padding(.top, max(min(15 + offset / 10, 15), 5))
        .background(LinearGradient(colors: [tier.tierBackgroundColor, Color(.systemBackground)], startPoint: .top, endPoint: .bottom))
    }
}

#Preview {
    ProfileHeader(tier: 16, rating: 1650, frames: [])
}
