import Foundation
import MLBDomain
import SwiftDate

public enum GameStatus: String, Codable {
    case final = "Final"
    case live = "Live"
    case preview = "Preview"
    case warmup = "Warmup"
    case inProgress = "In Progress"
    case scheduled = "Scheduled"
    case unknown
}

public struct StatusPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var date: Date
    public var status: GameStatus
    public let reason: String?
    public let currentInning: String?
    public let inningState: InningState
    
    init(status: Status, startDate: Date, currentInning: String?, inningState: InningState) {
        self.id = UUID().uuidString
        self.status = GameStatus(rawValue: status.detailedState) ?? .unknown
        self.date = startDate
        self.reason = status.reason
        self.currentInning = currentInning
        self.inningState = inningState
    }
}

public struct RecordPresenter : Equatable, Hashable {
    public let wins: String
    public let losses: String
    public let winningPercentage: String

    public init(_ record: Teams.Team.LeagueRecord) {
        self.wins = String( record.wins )
        self.losses = String( record.losses )
        self.winningPercentage = record.pct
    }
}

public struct PlayerPresenter : Equatable, Hashable {
    public var id: String = ""
    public var name: String = ""
    public var recordSummary: String = ""
    
    public init?(_ player: Player?) {
        guard let player else { return nil }
        
        self.id = String( player.number )
        self.name = player.fullName
        let stats = player.stats
            .filter { $0.group.displayName == "pitching" && $0.type.displayName == "statsSingleSeason" }
            .first
    
        self.recordSummary = stats?.stats.summary ?? ""
    }
}

public struct TeamPresenter : Equatable, Hashable {
    public var teamId: String
    public let seasonRecord: RecordPresenter
    public let probablePitcher: PlayerPresenter?
    public let score: String
    
    public let abbreviation: String
    public let teamName: String
    public let locationName: String
    
    public let winner: PlayerPresenter?
    public let loser: PlayerPresenter?
    public let save: PlayerPresenter?
    
    
    public init(_ team: Teams.Team, decisions: Decisions?) {
        self.teamId = String( team.team.id )
        self.seasonRecord = RecordPresenter(team.leagueRecord)
        self.probablePitcher = PlayerPresenter(team.probablePitcher)
        self.score = team.score?.toString() ?? "0"
        
        self.abbreviation = team.team.abbreviation
        self.teamName = team.team.teamName
        self.locationName = team.team.locationName
        
        if team.isWinner == true {
            self.winner = PlayerPresenter(decisions?.winner)
            self.save = PlayerPresenter(decisions?.save)
            self.loser = nil
        } else {
            self.winner = nil
            self.save = nil
            self.loser = PlayerPresenter(decisions?.loser)
        }
    }
}

public enum InningState: String, Codable {
    case top = "Top"
    case bottom = "Bottom"
    case middle = "Middle"
    case end = "End"
    
    public func text() -> String {
        switch self {
        case .top:
            return "TOP"
        case .bottom:
            return "BOT"
        case .middle:
            return "MID"
        case .end:
            return "END"
        }
    }
}

public struct InningTeamPresenter: Equatable, Hashable {
    public let runs: String
    public let hits: String
    public let errors: String
    
    public init(_ inningTeam: InningTeam) {
        self.runs = inningTeam.runs?.toString() ?? "0"
        self.hits = inningTeam.hits?.toString() ?? "0"
        self.errors = inningTeam.errors?.toString() ?? "0"
    }
}

public struct InningPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let num: String
    public let ordinalNum: String
    public let away: InningTeamPresenter
    public let home: InningTeamPresenter
    
    public init(_ inning: Inning) {
        id = UUID().uuidString
        self.num = inning.num.toString()
        self.ordinalNum = inning.ordinalNum
        self.away = InningTeamPresenter(inning.away)
        self.home = InningTeamPresenter(inning.home)
    }
}

public struct LinescorePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let currentInning: String?
    public let currentInningOrdinal: String?
    public let inningState: InningState
    public let innings: [InningPresenter]
    
    public init(_ lineScore: LineScore) {
        id = UUID().uuidString
        self.currentInning =  String( lineScore.currentInning ?? 1 )
        self.currentInningOrdinal = lineScore.currentInningOrdinal
        let state = lineScore.inningState ?? ""
        self.inningState = InningState(rawValue: state) ?? .top
        self.innings = lineScore.innings.map { InningPresenter($0) }
    }
}

public struct GamePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let startDate: Date
    public let status: StatusPresenter
    public let away: TeamPresenter
    public let home: TeamPresenter
    public let linescore: LinescorePresenter
    
    public init(_ game: Game) {
        id = UUID().uuidString
        startDate = game.gameDate.toISODate(region: .UTC)?.date ?? .now
        away = TeamPresenter(game.teams.away, decisions: game.decisions)
        home = TeamPresenter(game.teams.home, decisions: game.decisions)
        
        linescore = LinescorePresenter(game.linescore)
        
        
        status = StatusPresenter(
            status: game.status,
            startDate: startDate,
            currentInning: linescore.currentInningOrdinal,
            inningState: linescore.inningState
        )
    }
}


public struct SchedulePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let date: String
    public var games: [GamePresenter]
    
    public init(_ schedule: Schedule) {
        id = UUID().uuidString
        games = schedule.games.map { GamePresenter($0) }
        date = games.first?.startDate.toFormat("yyyy-MM-dd Z", locale: Locales.current) ?? ""
    }
    
    public static func create(_ schedules: [Schedule]) -> [SchedulePresenter] {
        return schedules.map { SchedulePresenter($0) }
    }
}


extension Int {
    func toString() -> String {
        String(self)
    }
}
