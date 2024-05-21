//
//  MLBLiveWidget.swift
//  MLBLiveWidget
//
//  Created by Junghoon on 2024/05/16.
//

import WidgetKit
import SwiftUI
import SwiftDate

struct IntentsTeamProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date.now, info: nil)
    }
    func getSnapshot(for configuration: TeamIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date.now, info: nil)
        completion(entry)
    }
    
    func getTimeline(for configuration: TeamIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            let teamInfo = MLBTeam.all
                .first(where: { $0.name == configuration.team?.displayString })
            
            let info = await WidgetProvider.fetch(teamId: teamInfo?.code)
            if let info = info, let item = info.game {
                if item.state == .final {
                    
                    let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: .now)!
                    let entries = SimpleEntry(date: entryDate, info: info)
                    let timeline = Timeline(entries: [entries], policy: .after(entryDate))
                    completion(timeline)
                    
                } else if item.state == .preview {
                    let entryDate = item.date
                    let entries = SimpleEntry(date: entryDate, info: info)
                    let timeline = Timeline(entries: [entries], policy: .after(entryDate))
                    completion(timeline)
                    
                } else if item.state == .live {
                    let now = Date.now
                    let entryDate = now.dateByAdding(5, .minute).date
                    let entries = [SimpleEntry(date: now, info: info)]
                    
                    let timeline = Timeline(entries: entries, policy: .after(entryDate))
                    completion(timeline)
                }
            }
            
        }
    }
}

//struct Provider: TimelineProvider {
//    func placeholder(in context: Context) -> SimpleEntry {
//        SimpleEntry(date: Date.now, info: nil)
//    }
//    
//    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
//        let entry = SimpleEntry(date: Date.now, info: nil)
//        completion(entry)
//    }
//    
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        Task {
//            var entries: [SimpleEntry] = []
//            let (item, awayStanding, homeStanding) = await WidgetProvider.fetch(teamId: nil)
//            if let item {
//                if item.state == .final {
//                    
//                    let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: .now)!
//                    let entries = SimpleEntry(date: entryDate, game: item, awayStanding: awayStanding, homeStanding: homeStanding)
//                    let timeline = Timeline(entries: [entries], policy: .after(entryDate))
//                    completion(timeline)
//                    
//                } else if item.state == .preview {
//                    let entryDate = item.date
//                    let entries = SimpleEntry(date: entryDate, game: item, awayStanding: awayStanding, homeStanding: homeStanding)
//                    let timeline = Timeline(entries: [entries], policy: .after(entryDate))
//                    completion(timeline)
//                    
//                } else if item.state == .live {
//                    let now = Date.now
//                    let entryDate = now.dateByAdding(5, .minute).date
//                    entries = [SimpleEntry(date: now, game: item, awayStanding: awayStanding, homeStanding: homeStanding)]
//                    
//                    let timeline = Timeline(entries: entries, policy: .after(entryDate))
//                    completion(timeline)
//                }
//            }
//            
//        }
//    }
//}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let info: GameInfo?
}

struct InningsView : View {
    var body: some View {
        VStack(spacing: 3) {
            Text("Top 5")
            VStack {
                
            }
            .frame(width: 60, height: 43, alignment: .center)
            .background(alignment: .top) {
                Image(systemName: "diamond")
                    .resizable()
                    .foregroundStyle(.blue)
                    .frame(width: 27, height: 27, alignment: .center)
            }
            .background(alignment: .bottomLeading) {
                Image(systemName: "diamond.fill")
                    .resizable()
                    .foregroundStyle(.blue)
                    .frame(width: 27, height: 27, alignment: .center)
            }
            .background(alignment: .bottomTrailing) {
                Image(systemName: "diamond")
                    .resizable()
                    .foregroundStyle(.blue)
                    .frame(width: 27, height: 27, alignment: .center)
            }
            
            Text("2-1")
            
            HStack {
                ForEach(0...2, id: \.self) { index in
                    if (index) < Int(2) ?? 0 {
                        Circle()
                            .frame(width: 15, height: 15, alignment: .center)
                            .foregroundStyle(.red)
                    } else {
                        Circle()
                            .frame(width: 15, height: 15, alignment: .center)
                            .foregroundStyle(.gray)
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
    
}

struct MLBLiveWidgetEntryView : View {
    var entry: IntentsTeamProvider.Entry
    var game: Game?
    
    init(entry: IntentsTeamProvider.Entry) {
        self.entry = entry
        self.game = entry.info?.game
    }
    
    var body: some View {
        
        if let game {
            switch game.state {
            case .final:
                WFinalView(info: entry.info)
            case .live:
                WLiveView(game: game)
            case .preview:
                WNextGameView(info: entry.info)
            case .warmup:
                WidgetLiveStatusView(game: game)
            case .inProgress:
                WidgetLiveStatusView(game: game)
            case .unknown:
                WidgetLiveStatusView(game: game)
            }
        }
    }
}

struct MLBLiveWidget: Widget {
    let kind: String = "MLBLiveMediumWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: TeamIntent.self , provider: IntentsTeamProvider()) { entry in
            MLBLiveWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widget")
        .supportedFamilies([.systemMedium])
        .description("This is an example widget.")
    }
}

#Preview(as: .systemMedium) {
    MLBLiveWidget()
} timeline: {
    SimpleEntry(date: .now, info: nil)
}
