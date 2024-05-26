import Foundation

public struct Status: Equatable, Hashable {
    public let abstractGameState: String
    public let detailedState: String
    public let reason: String?
    
    public init(abstractGameState: String, detailedState: String, reason: String?) {
        self.abstractGameState = abstractGameState
        self.detailedState = detailedState
        self.reason = reason
    }
}

public struct Player: Equatable, Hashable {
    public let number: Int
    public let fullName: String
    public let stats: [PlayerStats]
    
    public init(number: Int, fullName: String, stats: [PlayerStats]) {
        self.number = number
        self.fullName = fullName
        self.stats = stats
    }
    
    public struct PlayerStats: Equatable, Hashable {
        public let group: StatsGroup // hitting, pitching
        public let type: StatsGroup // statsSingleSeason, gameLog
        public let stats: Stats

        public init(group: StatsGroup, type: StatsGroup, stats: Stats) {
            self.group = group
            self.type = type
            self.stats = stats
        }
        
        public struct Stats: Equatable, Hashable {
            public let summary: String?
            public let era: String?
            
            public let wins: Int?
            public let losses: Int?
            public init(summary: String?, era: String?, wins: Int?, losses: Int?) {
                self.summary = summary
                self.era = era
                self.wins = wins
                self.losses = losses
            }
        }
        
        public struct StatsGroup: Equatable, Hashable {
            public let displayName: String
            
            public init(displayName: String) {
                self.displayName = displayName
            }
        }
    }
}

public struct Teams: Equatable, Hashable {
    public let away: Team
    public let home: Team
    
    public init(away: Team, home: Team) {
        self.away = away
        self.home = home
    }
    
    public struct Team: Equatable, Hashable {
        public let leagueRecord: LeagueRecord
        public let score: Int?
        public let isWinner: Bool?
        public let probablePitcher: Player?
        public let team: EachTeam
        
        public init(leagueRecord: LeagueRecord, score: Int?, isWinner: Bool?, probablePitcher: Player?, team: EachTeam) {
            self.leagueRecord = leagueRecord
            self.score = score
            self.isWinner = isWinner
            self.probablePitcher = probablePitcher
            self.team = team
        }
        
        public struct EachTeam: Equatable, Hashable {
            public let id: Int
            public let abbreviation: String
            public let teamName: String
            public let locationName: String
            public let franchiseName: String
            public init(id: Int, abbreviation: String, teamName: String, locationName: String, franchiseName: String) {
                self.id = id
                self.abbreviation = abbreviation
                self.teamName = teamName
                self.locationName = locationName
                self.franchiseName = franchiseName
            }
        }
        
        public struct LeagueRecord: Equatable, Hashable {
            public let wins: Int
            public let losses: Int
            public let pct: String
            
            public init(wins: Int, losses: Int, pct: String) {
                self.wins = wins
                self.losses = losses
                self.pct = pct
            }
        }
    }
}

public struct Decisions: Equatable, Hashable {
    public let winner: Player
    public let loser: Player
    public let save: Player?
    
    public init(winner: Player, loser: Player, save: Player?) {
        self.winner = winner
        self.loser = loser
        self.save = save
    }
}

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


public struct Game: Equatable, Hashable {
    public let gamePk: Int
    public let gameDate: String
    public let status: Status
    public let teams: Teams
    public let decisions: Decisions?
    public let linescore: LineScore?
    
    public init(gamePk: Int, gameDate: String, status: Status, teams: Teams, decisions: Decisions?, linescore: LineScore?) {
        self.gamePk = gamePk
        self.gameDate = gameDate
        self.status = status
        self.teams = teams
        self.decisions = decisions
        self.linescore = linescore
    }
}

public struct Schedule: Equatable, Hashable {
    public let games: [Game]
    public let date: String?
    
    public init(games: [Game], date: String?) {
        self.games = games
        self.date = date
    }
}


public struct MLBPlan: Equatable, Hashable {
    public let schedules: [Schedule]
    
    public init(schedules: [Schedule]) {
        self.schedules = schedules
    }
}
