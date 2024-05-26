import Foundation

public struct InningTeam: Equatable, Hashable {
    public let runs: Int?
    public let hits: Int?
    public let errors: Int?

    public init(runs: Int?, hits: Int?, errors: Int?) {
        self.runs = runs
        self.hits = hits
        self.errors = errors
    }
}

public struct Inning: Equatable, Hashable {
    public let num: Int
    public let ordinalNum: String
    public let away: InningTeam
    public let home: InningTeam
    
    public init(num: Int, ordinalNum: String, away: InningTeam, home: InningTeam) {
        self.num = num
        self.ordinalNum = ordinalNum
        self.away = away
        self.home = home
    }
}

public struct LineScoreTeams: Equatable, Hashable {
    public let away: InningTeam
    public let home: InningTeam
    
    public init(away: InningTeam, home: InningTeam) {
        self.away = away
        self.home = home
    }
}

public struct LineScore: Equatable, Hashable {
    public let currentInning: Int?
    public let currentInningOrdinal: String?
    public let inningState: String?
    public let innings: [Inning]
    public let teams: LineScoreTeams
    public init(currentInning: Int?, currentInningOrdinal: String?, inningState: String?, innings: [Inning], teams: LineScoreTeams) {
        self.currentInning = currentInning
        self.currentInningOrdinal = currentInningOrdinal
        self.inningState = inningState
        self.innings = innings
        self.teams = teams
    }
}
