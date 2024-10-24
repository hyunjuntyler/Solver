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
    
    static var descriptor: FetchDescriptor<User> {
        return FetchDescriptor()
    }
    
    var body: some View {
        if let user = user.first {
            switch family {
            case .systemSmall: SmallWidget(user: user)
            case .systemMedium: MediumWidget(user: user)
            default: Text("Not implemented")
            }
        } else {
            ContentUnavailable
        }
    }
    
    var ContentUnavailable: some View {
        VStack {
            Text("🧑🏻‍💻👩🏻‍💻")
                .font(.tossTitle3)
            Text("아이디를 등록해주세요")
                .font(.caption)
        }
        .containerBackground(.fill.tertiary, for: .widget)
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
