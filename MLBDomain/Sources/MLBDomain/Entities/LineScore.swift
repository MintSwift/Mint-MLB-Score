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
public struct Defense: Equatable, Hashable {
    public let pitcher: LivePlayer.PlayerPerson?

    public init(pitcher: LivePlayer.PlayerPerson?) {
        self.pitcher = pitcher
    }
}

public struct Offense: Equatable, Hashable {
    public let batter: LivePlayer.PlayerPerson?
    public let first: LivePlayer.PlayerPerson?
    public let second: LivePlayer.PlayerPerson?
    public let third: LivePlayer.PlayerPerson?
    public let onDeck: LivePlayer.PlayerPerson?
    
    public init(
        batter: LivePlayer.PlayerPerson?,
        first: LivePlayer.PlayerPerson?,
        second: LivePlayer.PlayerPerson?,
        third: LivePlayer.PlayerPerson?,
        onDeck: LivePlayer.PlayerPerson?
    ) {
        self.batter = batter
        self.onDeck = onDeck
        self.first = first
        self.second = second
        self.third = third
    }
}

public struct BallCount: Equatable, Hashable {
    public let balls: Int
    public let strikes: Int
    public let outs: Int
    
    public init(balls: Int?, strikes: Int?, outs: Int?) {
        self.balls = balls ?? 0
        self.strikes = strikes ?? 0
        self.outs = outs ?? 0
    }
}

public struct LineScore: Equatable, Hashable {
    public let currentInning: Int?
    public let currentInningOrdinal: String?
    public let inningState: String?
    public let innings: [Inning]
    public let teams: LineScoreTeams
    public let offense: Offense
    public let defense: Defense
    public let count: BallCount
    
    public init(
        currentInning: Int?,
        currentInningOrdinal: String?,
        inningState: String?,
        innings: [Inning],
        teams: LineScoreTeams,
        offense: Offense,
        defense: Defense,
        count: BallCount
    ) {
        self.currentInning = currentInning
        self.currentInningOrdinal = currentInningOrdinal
        self.inningState = inningState
        self.innings = innings
        self.teams = teams
        self.offense = offense
        self.defense = defense
        self.count = count
    }
}

