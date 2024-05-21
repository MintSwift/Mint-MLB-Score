
import WidgetKit
import SwiftUI
import SwiftDate

struct IntentsPostSeasonProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> TeamStandingsEntry {
        TeamStandingsEntry(date: .now, leaders: [], wildCardRanks: [], league: "AL")
    }
    func getSnapshot(for configuration: LeagueIntent, in context: Context, completion: @escaping (TeamStandingsEntry) -> ()) {
        let entry = TeamStandingsEntry(date: .now, leaders: [], wildCardRanks: [],  league: "AL")
        completion(entry)
    }
    
    func getTimeline(for configuration: LeagueIntent, in context: Context, completion: @escaping (Timeline<TeamStandingsEntry>) -> ()) {
        Task {
            let league = configuration.League
            let (leader, wildcardRanks) = await WidgetProvider.standings(league: league.rawValue)
            let now = Date.now
            let ceilDate = now.dateRoundedAt(at: .toFloorMins(60)).date
            let refresh = ceilDate.dateByAdding(2, .hour).date
            
            let entries = TeamStandingsEntry(date: now,
                                             leaders: leader,
                                             wildCardRanks: wildcardRanks,
                                             league: league.rawValue == 1 ? "AL" : "NL")
            let timeline = Timeline(entries: [entries], policy: .after(refresh))
            completion(timeline)
        }
    }
}



struct TeamStandingsEntry: TimelineEntry {
    let date: Date
    let leaders: [TeamStandings]
    let wildCardRanks: [TeamStandings]
    let league: String
}


struct MLBTeamStandingsView : View {
    var entry: IntentsPostSeasonProvider.Entry
    
    init(entry: IntentsPostSeasonProvider.Entry) {
        self.entry = entry
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 3) {
                HStack {
                    Spacer()
                    Text(entry.date.toFormat("yyyy.MM.dd HH:mm", locale: Locales.korean))
                        .foregroundStyle(.tertiary)
                        .font(.caption2)
                }
                
                Divider()
            }
            
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    Text("\(entry.league) Leaders")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Text("W")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                        Text("L")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                        Text("PCT")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                        
                        Text("WCGB")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                    }
                }
                
                Divider()
                    
            
                
                ForEach(entry.leaders, id: \.self) { leader in
                    HStack(spacing: 0) {
                        HStack {
                            if let team = MLBTeam.all.first(where: { leader.name.contains($0.name) }) {
                                Image("C_\(team.abbreviation)")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .scaledToFit()
                                
                                
                                Text("\(team.name) - \(team.division.name().first?.uppercased() ?? "")")
                                    .font(.footnote)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                        }
                        
                        HStack(spacing: 3) {
                            Text(String( leader.wins ))
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                            Text(String( leader.losses ))
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                            Text(leader.winningPercentage)
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                            Text(leader.wildCardGamesBack)
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                        }
                    }
                }
            }
            
            Spacer()
            
            VStack(spacing: 8) {
                HStack(spacing: 0) {
                    Text("\(entry.league) Wild Card")
                        .font(.footnote)
                        .foregroundStyle(.secondary)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Spacer()
                    
                    HStack(spacing: 3) {
                        Text("W")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                        Text("L")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                        Text("PCT")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                        
                        Text("WCGB")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                            .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                    }
                }
                
                
                Divider()
                
                ForEach(Array( entry.wildCardRanks.prefix(3) ) , id: \.self) { leader in
                    HStack(spacing: 0) {
                        HStack {
                            if let team = MLBTeam.all.first(where: { leader.name.contains($0.name) }) {
                                Image("C_\(team.abbreviation)")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .scaledToFit()
                                
                                Text(team.name)
                                    .font(.footnote)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        HStack(spacing: 3) {
                            Text(String( leader.wins ))
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                            Text(String( leader.losses ))
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                            Text(leader.winningPercentage)
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                            Text(leader.wildCardGamesBack)
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                        }
                    }
                }
                
                Line()
                    .stroke(style: .init(dash: [3]))
                    .foregroundStyle(.gray)
                    .frame(height: 2)
                
                ForEach(Array( entry.wildCardRanks.suffix(3) ), id: \.self) { leader in
                    HStack(spacing: 0) {
                        HStack {
                            if let team = MLBTeam.all.first(where: { leader.name.contains($0.name) }) {
                                Image("C_\(team.abbreviation)")
                                    .resizable()
                                    .frame(width: 18, height: 18)
                                    .scaledToFit()
                                
                                Text(team.name)
                                    .font(.footnote)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        
                        HStack(spacing: 3) {
                            Text(String( leader.wins ))
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                            Text(String( leader.losses ))
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                            Text(leader.winningPercentage)
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                            Text(leader.wildCardGamesBack)
                                .font(.footnote)
                                .containerRelativeFrame(.horizontal, count: 100, span: 13, spacing: 0)
                        }
                    }
                }
            }
        }
    }
}

struct MLBPostSeasonWidget: Widget {
    let kind: String = "MLBPostSeasonWidget"
    
    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: LeagueIntent.self , provider: IntentsPostSeasonProvider()) { entry in
            MLBTeamStandingsView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .configurationDisplayName("My Widge2t")
        .supportedFamilies([.systemLarge])
        .description("This is an example widg2et.")
    }
}
struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        return path
    }
}
