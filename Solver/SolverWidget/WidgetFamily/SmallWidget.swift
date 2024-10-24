//
//  SmallWidget.swift
//  Solver
//
//  Created by Hyunjun Kim on 4/29/24.
//

import WidgetKit
import SwiftUI

struct SmallWidget: View {
    var user: User
    
    var body: some View {
        VStack {
            HStack {
                ProfileImage(data: user.profile?.image, size: 16)
                Text(user.id)
                    .fontWeight(.semibold)
                    .font(.footnote)
            }
            
            TierBadge(tier: user.tier, size: 44)
                .shadow(radius: 0.5)
            
            Group {
                Text(user.tier.tierName)
                Text(String(user.rating))
            }
            .font(.footnote)
            .foregroundStyle(user.tier.tierColor)
            .fontWeight(.bold)
        }
        .containerBackground(LinearGradient(colors: [user.tier.tierBackgroundColor, Color(.tertiarySystemBackground)], startPoint: .top, endPoint: .bottom), for: .widget)
    }
}

#Preview(as: .systemSmall) {
    SolverWidget()
} timeline: {
    SimpleEntry(date: .now)
}
