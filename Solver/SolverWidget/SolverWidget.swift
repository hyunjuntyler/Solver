//
//  SolverWidget.swift
//  SolverWidget
//
//  Created by hyunjun on 4/29/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date())
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(date: .now)], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
}

struct SolverWidgetEntryView : View {
    @Environment(\.widgetFamily) private var family
    var entry: Provider.Entry
    @Query(descriptor, animation: .snappy) private var user: [User]
    
    var body: some View {
        if let user = user.first {
            switch family {
            case .systemSmall: SmallView(user)
            case .systemMedium: MediumView(user)
            default: Text("Not implemented")
            }
        } else {
            Text("유저정보")
        }
    }
    
    @ViewBuilder
    private func SmallView(_ user: User) -> some View {
            VStack {
                HStack {
                    ProfileImage(data: user.profile?.image, size: 16)
                    Text(user.id)
                        .fontWeight(.semibold)
                }
                TierBadge(tier: user.tier, size: 56)
                    .shadow(radius: 0.5)
                HStack {
                    Text(user.tier.tierName)
                    Text(String(user.rating))
                }
                .foregroundStyle(user.tier.tierColor)
                .fontWeight(.bold)
                .font(.title3)
            }
            .containerBackground(LinearGradient(colors: [user.tier.tierBackgroundColor, Color(.tertiarySystemBackground)], startPoint: .top, endPoint: .bottom), for: .widget)
    }
    
    @ViewBuilder
    private func MediumView(_ user: User) -> some View {
        VStack {
            HStack {
                ProfileImage(data: user.profile?.image, size: 24)
                Text(user.id)
                    .font(.title3)
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
                                .fontWeight(.semibold)
                        }
                        .foregroundStyle(.secondary)
                        .font(.caption)
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
    
    static var descriptor: FetchDescriptor<User> {
        return FetchDescriptor()
    }
}

struct SolverWidget: Widget {
    let kind: String = "SolverWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
                SolverWidgetEntryView(entry: entry)
                    .modelContainer(for: User.self)
        }
        .supportedFamilies([.systemSmall, .systemMedium])
        .configurationDisplayName("내 프로필")
        .description("내 프로필 정보를 한눈에 확인할 수 있어요")
    }
}

#Preview(as: .systemSmall) {
    SolverWidget()
} timeline: {
    SimpleEntry(date: .now)
}

#Preview(as: .systemMedium) {
    SolverWidget()
} timeline: {
    SimpleEntry(date: .now)
}
