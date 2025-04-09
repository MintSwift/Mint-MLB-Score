import Foundation
import MLBDomain
import SwiftDate

public struct StatusPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var date: Date
    public var status: GameStatus
    public var reason: String?
    public let currentInning: String?
    public let inningState: InningState
    
    init(status: Status, startDate: Date, currentInning: String?, inningState: InningState) {
        self.id = UUID().uuidString
        self.reason = status.reason
        if let status = GameStatus(rawValue: status.detailedState) {
            self.status = status
        } else {
            self.status = .unknown
            self.reason = status.detailedState
        }
        
        self.date = startDate
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
    public var saves: String?
    public var era: String = "-"
    
    public init?(_ player: Player?) {
        guard let player else { return nil }
        
        self.id = String( player.number )
        self.name = player.fullName
        let stats = player.stats
            .filter { $0.group.displayName == "pitching" && $0.type.displayName == "statsSingleSeason" }
            .first
    
        if let saves = stats?.stats.saves {
            self.saves = String( saves )
        } else {
            self.saves = nil
        }
        
        self.era = stats?.stats.era ?? "-"
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
        self.locationName = team.team.franchiseName
        
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
        self.runs = inningTeam.runs?.toString() ?? " "
        self.hits = inningTeam.hits?.toString() ?? " "
        self.errors = inningTeam.errors?.toString() ?? " "
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

public struct LinescoreTeamPresenter: Equatable, Hashable {
    public let away: InningTeamPresenter
    public let home: InningTeamPresenter
    
    public init(away: InningTeamPresenter, home: InningTeamPresenter) {
        self.away = away
        self.home = home
    }
}

public struct LinescorePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var currentInning: String? = nil
    public var currentInningOrdinal: String? = nil
    public var inningState: InningState = .top
    public var innings: [InningPresenter] = []
    public var teams: LinescoreTeamPresenter? = nil
    
    public var offense: OffensePresenter? = nil
    public var defense: DefensePresenter? = nil
    
    public init(_ lineScore: LineScore?) {
        id = UUID().uuidString
        if let lineScore {
            self.offense = OffensePresenter(lineScore.offense)
            self.defense = DefensePresenter(lineScore.defense)
            
            let away = InningTeamPresenter(lineScore.teams.away)
            let home = InningTeamPresenter(lineScore.teams.home)
            self.teams = LinescoreTeamPresenter(away: away, home: home)
            
            self.currentInning =  String( lineScore.currentInning ?? 1 )
            self.currentInningOrdinal = lineScore.currentInningOrdinal
            let state = lineScore.inningState ?? ""
            self.inningState = InningState(rawValue: state) ?? .top
            self.innings = lineScore.innings.map { InningPresenter($0) }
            
            
            var allInnings: [InningPresenter] = []
            for inning in lineScore.innings {
                allInnings.append(InningPresenter(inning))
            }
            
            if allInnings.count < 9 {
                let number = 9 - allInnings.count
                for _ in 1...number {
                    let number = Int( allInnings.last?.num ?? "0" ) ?? 0
                    let lastNumber = number + 1
                    let stringLast = String(lastNumber).ordinal()
                    
                    let inning = Inning(num: lastNumber,
                                        ordinalNum: stringLast ?? "",
                                        away: InningTeam(runs: nil, hits: nil, errors: nil),
                                        home: InningTeam(runs: nil, hits: nil, errors: nil))
                    allInnings.append(InningPresenter(inning))
                }
            }
            
            let maxCount = Array(allInnings.suffix(9))
            self.innings = maxCount
        }
        
    }
}

extension String {
    func ordinal() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        if let e = Int(self) {
            return formatter.string(from: NSNumber(integerLiteral: e))
        }
        
        return nil
    }
}

public struct GamePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let startDate: Date
    public let gameId: Int
    public let status: StatusPresenter
    public let away: TeamPresenter
    public let home: TeamPresenter
    public let linescore: LinescorePresenter
    
    public init(_ game: Game) {
        id = UUID().uuidString
        startDate = game.gameDate.toISODate(region: .UTC)?.date ?? .now
        away = TeamPresenter(game.teams.away, decisions: game.decisions)
        home = TeamPresenter(game.teams.home, decisions: game.decisions)
        gameId = game.gamePk
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
