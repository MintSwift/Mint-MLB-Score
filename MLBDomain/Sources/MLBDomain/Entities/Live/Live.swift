import Foundation

public struct PitcherStats: Equatable, Hashable {
    public let summary: String?
    public let inningsPitched: String?
    public let hits: Int?
    public let runs: Int?
    public let earnedRuns: Int?
    public let baseOnBalls: Int?
    public let strikeOuts: Int?
    public let homeRuns: Int?
    
    public let era: String?
    
    public init(summary: String?, inningsPitched: String?, hits: Int?, runs: Int?, earnedRuns: Int?, baseOnBalls: Int?, strikeOuts: Int?, homeRuns: Int?, era: String?) {
        self.summary = summary
        self.inningsPitched = inningsPitched
        self.hits = hits
        self.runs = runs
        self.earnedRuns = earnedRuns
        self.baseOnBalls = baseOnBalls
        self.strikeOuts = strikeOuts
        self.homeRuns = homeRuns
        self.era = era
    }
}

public struct BattingState: Equatable, Hashable {
    public let summary: String?
    public let runs: Int?
    public let homeRuns: Int?
    public let atBats: Int?
    public let strikeOuts: Int?
    public let hits: Int?
    public let rbi: Int?
    public let baseOnBalls: Int?
    public let leftOnBase: Int?
    
    public let avg: String?
    public let ops: String?

    public init(summary: String?, runs: Int?, homeRuns: Int?, atBats: Int?, strikeOuts: Int?, hits: Int?, rbi: Int?, baseOnBalls: Int?, leftOnBase: Int?, avg: String?, ops: String?) {
        self.summary = summary
        self.runs = runs
        self.homeRuns = homeRuns
        self.atBats = atBats
        self.strikeOuts = strikeOuts
        self.hits = hits
        self.rbi = rbi
        self.baseOnBalls = baseOnBalls
        self.leftOnBase = leftOnBase
        self.avg = avg
        self.ops = ops
    }
}

public struct PlayerStats: Equatable, Hashable {
    public let batting: BattingState?
    public let pitching: PitcherStats?
    
    public init(batting: BattingState?, pitching: PitcherStats?) {
        self.batting = batting
        self.pitching = pitching
    }
}

public struct LivePlayer: Equatable, Hashable {
    public let person: PlayerPerson
    public let battingOrder: String?
    public let stats: PlayerStats
    public let seasonStats: PlayerStats
    
    public struct PlayerPerson: Equatable, Hashable {
        public let id: Int
        public let fullName: String
        
        public init(id: Int, fullName: String) {
            self.id = id
            self.fullName = fullName
        }
    }
    
    public init(person: PlayerPerson, battingOrder: String?, stats: PlayerStats, seasonStats: PlayerStats) {
        self.person = person
        self.battingOrder = battingOrder
        self.stats = stats
        self.seasonStats = seasonStats
    }
}

public struct LiveTeam: Equatable, Hashable {
    public let players: [String: LivePlayer]
    public let batters: [LivePlayer]
    public let pitchers: [LivePlayer]
    
    public init(players: [String : LivePlayer], batters: [LivePlayer], pitchers: [LivePlayer]) {
        self.players = players
        self.batters = batters
        self.pitchers = pitchers
    }
}

public struct LiveTeams: Equatable, Hashable {
    public let away: LiveTeam
    public let home: LiveTeam
    
    public init(away: LiveTeam, home: LiveTeam) {
        self.away = away
        self.home = home
    }
}

public struct GamePlayers: Equatable, Hashable {
    public let id: Int
    public let fullName: String
    public let firstName: String
    public let lastName: String
    public let boxscoreName: String
    
    public init(id: Int, fullName: String, firstName: String, lastName: String, boxscoreName: String) {
        self.id = id
        self.fullName = fullName
        self.firstName = firstName
        self.lastName = lastName
        self.boxscoreName = boxscoreName
    }
}

public struct GameData: Equatable, Hashable {
    public let status: Status
    public let players: [String: GamePlayers]
    
    public init(status: Status, players: [String : GamePlayers]) {
        self.status = status
        self.players = players
    }
}

public struct BoxScore: Equatable, Hashable {
    public let teams: LiveTeams
    public init(teams: LiveTeams) {
        self.teams = teams
    }
}

public struct LiveData: Equatable, Hashable {
    public let boxscore: BoxScore
    public let linescore: LineScore
    
    public init(boxscore: BoxScore, linescore: LineScore) {
        self.boxscore = boxscore
        self.linescore = linescore
    }
}

public struct Live: Equatable, Hashable {
    public let gameData: GameData
    public let liveData: LiveData
    
    public init(gameData: GameData, liveData: LiveData) {
        self.gameData = gameData
        self.liveData = liveData
    }
}
