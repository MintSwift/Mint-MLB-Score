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
    
    public let number: Int
    
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
        self.number = Int( player.person.id )
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


public struct DefensePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var pitcherNumber: Int?
    public var pitcherName: String?
    
    public init(_  defense: Defense) {
        id = UUID().uuidString

        self.pitcherNumber = defense.pitcher?.id
        self.pitcherName = defense.pitcher?.fullName
    }
}


public struct PlayerPersonPresenter: Equatable, Hashable {
    public let id: Int
    public let fullName: String
    
    public init(id: Int, fullName: String) {
        self.id = id
        self.fullName = fullName
    }
}

public struct OffensePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var batter: PlayerPersonPresenter? = nil
    public var first: PlayerPersonPresenter? = nil
    public var second: PlayerPersonPresenter? = nil
    public var third: PlayerPersonPresenter? = nil
    public var onDeck: PlayerPersonPresenter? = nil
    
    public var batterNumber: Int?
    public var batterName: String?
    
    public var onDeckNumber: Int?
    public var onDeckName: String?
    
    public init(_ offense: Offense) {
        id = UUID().uuidString
        
        if let player = offense.batter {
            batter = PlayerPersonPresenter(id: player.id, fullName: player.fullName)
        }
        
        if let player = offense.first {
            first = PlayerPersonPresenter(id: player.id, fullName: player.fullName)
        }
        
        if let player = offense.second {
            second = PlayerPersonPresenter(id: player.id, fullName: player.fullName)
        }
        
        if let player = offense.third {
            third = PlayerPersonPresenter(id: player.id, fullName: player.fullName)
        }
        
        if let player = offense.onDeck {
            onDeck = PlayerPersonPresenter(id: player.id, fullName: player.fullName)
        }
        self.batterNumber = offense.batter?.id
        self.batterName = offense.batter?.fullName

        self.onDeckNumber = offense.onDeck?.id
        self.onDeckName = offense.onDeck?.fullName
    }
}

public struct BallCountPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let balls: Int
    public let strikes: Int
    public let outs: Int
    
    public init(balls: Int?, strikes: Int?, outs: Int?) {
        id = UUID().uuidString
        self.balls = balls ?? 0
        self.strikes = strikes ?? 0
        self.outs = outs ?? 0
    }
}

public struct LiveGamePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let away: TeamPlayersPresenter
    public let home: TeamPlayersPresenter
    
    public let defense: DefensePresenter
    public let offense: OffensePresenter
    public let linescore: LinescorePresenter
    
    public let status: StatusPresenter
    public let count: BallCountPresenter
    
    
    
    public init(_ live: Live) {
        id = UUID().uuidString
        
        let balls =  live.liveData.linescore.count.balls
        let strikes =  live.liveData.linescore.count.strikes
        let outs =  live.liveData.linescore.count.outs
        
        let state = live.liveData.linescore.inningState ?? ""
        let inningState = InningState(rawValue: state) ?? .top
        if inningState == .middle || inningState == .end {
            count = BallCountPresenter(balls: 0, strikes: 0, outs: 0)
        } else {
            count = BallCountPresenter(balls: balls, strikes: strikes, outs: outs)
        }
        
        self.status = StatusPresenter(
            status: live.gameData.status,
            startDate: .now,
            currentInning: live.liveData.linescore.currentInningOrdinal,
            inningState: inningState
        )
        
        let away = live.liveData.boxscore.teams.away
        
        self.away = TeamPlayersPresenter(away)
        
        let home = live.liveData.boxscore.teams.home
        self.home = TeamPlayersPresenter(home)
        
        self.offense = OffensePresenter(live.liveData.linescore.offense)
        self.defense = DefensePresenter(live.liveData.linescore.defense)
        self.linescore = LinescorePresenter(live.liveData.linescore)
       
    
    }
    
    public static func create(_ live: Live) -> LiveGamePresenter {
        return LiveGamePresenter(live)
    }
}
