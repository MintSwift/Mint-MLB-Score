//
//  MLBLiveWidget.swift
//  MLBLiveWidget
//
//  Created by Junghoon on 2024/05/16.
//

import WidgetKit
import SwiftUI
import SwiftDate

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date.now, game: nil, awayStanding: nil, homeStanding: nil)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date.now, game: nil, awayStanding: nil, homeStanding: nil)
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        Task {
            var entries: [SimpleEntry] = []
            let (item, awayStanding, homeStanding) = await WidgetProvider.fetch(teamId: nil)
            if let item {
                if item.state == .final {
                    
                    let entryDate = Calendar.current.date(byAdding: .hour, value: 1, to: .now)!
                    let entries = SimpleEntry(date: entryDate, game: item, awayStanding: awayStanding, homeStanding: homeStanding)
                    let timeline = Timeline(entries: [entries], policy: .after(entryDate))
                    completion(timeline)
                    
                } else if item.state == .preview {
                    let entryDate = item.date
                    let entries = SimpleEntry(date: entryDate, game: item, awayStanding: awayStanding, homeStanding: homeStanding)
                    let timeline = Timeline(entries: [entries], policy: .after(entryDate))
                    completion(timeline)
                    
                } else if item.state == .live {
                    let now = Date.now
                    let entryDate = now.dateByAdding(5, .minute).date
                    entries = [SimpleEntry(date: now, game: item, awayStanding: awayStanding, homeStanding: homeStanding)]
                    
                    let timeline = Timeline(entries: entries, policy: .after(entryDate))
                    completion(timeline)
                }
            }
            
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let game: Game?
    let awayStanding: TeamStandings?
    let homeStanding: TeamStandings?
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
    var entry: Provider.Entry
    var game: Game?
    
    init(entry: Provider.Entry) {
        self.entry = entry
        self.game = entry.game
    }
    
    var body: some View {
        
        if let game {
            switch game.state {
            case .final:
                WFinalView(game: game, away: entry.awayStanding, home: entry.homeStanding)
            case .live:
                VStack {
                    WLiveView(game: game)
                    Text(entry.date.toFormat("MM/dd hh:mm ss", locale: Locales.korean))
                        .foregroundStyle(.secondary)
                        .font(.caption2)
                    
                }
            case .preview:
                WNextGameView(game: game, away: entry.awayStanding, home: entry.homeStanding)
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
    let kind: String = "MLBLiveWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                MLBLiveWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                MLBLiveWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemMedium) {
    MLBLiveWidget()
} timeline: {
    SimpleEntry(date: .now, game: nil, awayStanding: nil, homeStanding: nil)
}
