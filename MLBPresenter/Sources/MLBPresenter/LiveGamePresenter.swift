import Foundation
import MLBDomain
import SwiftDate

public struct BatterStats: Identifiable, Equatable, Hashable {
    public var id: String
    public let summary: String
    public let runs: Int
    public let homeRuns: Int
    public let atBats: Int
    public let strikeOuts: Int
    public let hits: Int
    public let rbi: Int
    public let leftOnBase: Int
    
    public var avg: String
    public var ops: String
    
    public init(_  state: BattingState, avg: String, ops: String) {
        id = UUID().uuidString
        summary = state.summary ?? "-"
        runs = state.runs ?? 0
        homeRuns = state.homeRuns ?? 0
        atBats = state.atBats ?? 0
        strikeOuts = state.strikeOuts ?? 0
        hits = state.hits ?? 0
        rbi = state.rbi ?? 0
        leftOnBase = state.leftOnBase ?? 0
        
        self.avg = avg
        self.ops = ops
    }
}

public struct Stats: Identifiable, Equatable, Hashable {
    public var id: String
//    public let batter: BatterStats
    
    public init(_  today: PlayerStats, season: PlayerStats) {
        id = UUID().uuidString
        
    }
}

public struct BatterStatsPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let name: String
    
    public let battingOrder: Int
    public let summary: String
    public let runs: String
    public let homeRuns: String
    public let atBats: String
    public let strikeOuts: String
    public let hits: String
    public let rbi: String
    public let leftOnBase: String
    public let baseOnBalls: String
    
    public let avg: String
    public let ops: String

    
    public init(_  player: LivePlayer) {
        id = UUID().uuidString
        self.battingOrder = Int( player.battingOrder ?? "999" ) ?? 999
        self.name = player.person.fullName
        self.summary = player.stats.batting?.summary ?? "-"
        self.runs = String( player.stats.batting?.runs ?? 0 )
        self.homeRuns = String( player.stats.batting?.homeRuns ?? 0 )
        self.atBats = String( player.stats.batting?.atBats ?? 0 )
        self.strikeOuts = String( player.stats.batting?.strikeOuts ?? 0 )
        self.hits = String( player.stats.batting?.hits ?? 0 )
        self.rbi = String( player.stats.batting?.rbi ?? 0 )
        self.leftOnBase = String( player.stats.batting?.leftOnBase ?? 0 )
        self.baseOnBalls = String( player.stats.batting?.baseOnBalls ?? 0 )
        
        self.avg = player.seasonStats.batting?.avg ?? ".000"
        let ops = player.seasonStats.batting?.ops?.prefix(4)
        self.ops = String(ops ?? ".000")
    }
}

public struct PitcherStatsPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let name: String
    public let summary: String
    public let inningsPitched: String
    public let hits: String
    public let runs: String
    public let earnedRuns: String
    public let baseOnBalls: String
    public let strikeOuts: String
    public let homeRuns: String
    
    public let era: String
        
    public init(_  player: LivePlayer) {
        id = UUID().uuidString
        self.summary = player.stats.pitching?.summary ?? "-"
        self.inningsPitched = player.stats.pitching?.inningsPitched ?? ""
        self.hits = String( player.stats.pitching?.hits ?? 0 )
        self.runs = String( player.stats.pitching?.runs ?? 0 )
        self.earnedRuns = String( player.stats.pitching?.earnedRuns ?? 0 )
        self.baseOnBalls = String( player.stats.pitching?.baseOnBalls ?? 0 )
        self.strikeOuts = String( player.stats.pitching?.strikeOuts ?? 0 )
        self.homeRuns = String( player.stats.pitching?.homeRuns ?? 0 )
        self.name = player.person.fullName
        self.era = player.seasonStats.pitching?.era ?? "0.00"
    }
}

public struct TeamPlayersPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var batters: [BatterStatsPresenter]
    public var pitchers: [PitcherStatsPresenter]
    
    public init(_  team: LiveTeam) {
        id = UUID().uuidString
        self.batters = team.batters.filter { $0.battingOrder != nil }.map { BatterStatsPresenter($0) }
        self.pitchers = team.pitchers.map { PitcherStatsPresenter($0) }
    }
}


public struct LiveGamePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let away: TeamPlayersPresenter
    public let home: TeamPlayersPresenter

    
    public init(_ live: Live) {
        id = UUID().uuidString
        
        let away = live.liveData.boxscore.teams.away
        self.away = TeamPlayersPresenter(away)
        
        let home = live.liveData.boxscore.teams.home
        self.home = TeamPlayersPresenter(home)
    }
    
    public static func create(_ live: Live) -> LiveGamePresenter {
        return LiveGamePresenter(live)
    }
}
