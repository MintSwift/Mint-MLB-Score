import Foundation

public struct StatusDTO: Decodable {
    public let abstractGameState: String
    public let detailedState: String
    public let reason: String?
    
    enum CodingKeys: CodingKey {
        case abstractGameState
        case detailedState
        case reason
    }
}

public struct PlayerDTO: Decodable {
    public let id: Int
    public let fullName: String
    public let stats: [PlayerStatsDTO]
    enum CodingKeys: CodingKey {
        case id
        case fullName
        case stats
    }
    
    public struct PlayerStatsDTO: Decodable {
        public let group: StatsGroupDTO // hitting, pitching
        public let type: StatsGroupDTO // statsSingleSeason, gameLog
        public let stats: StatsDTO

        enum CodingKeys: CodingKey {
            case group
            case stats
            case type
        }
        
        public struct StatsDTO: Decodable {
            public let summary: String?
            public let era: String?
            
            public let wins: Int?
            public let losses: Int?
            public let saves: Int?

            enum CodingKeys: CodingKey {
                case summary
                case era
                case wins
                case losses
                case saves
            }
        }
        
        public struct StatsGroupDTO: Decodable {
            public let displayName: String

            enum CodingKeys: CodingKey {
                case displayName
            }
        }
    }
}

public struct TeamsDTO: Decodable {
    public let away: TeamDTO
    public let home: TeamDTO
    
    enum CodingKeys: CodingKey {
        case away
        case home
    }
    
    public struct TeamDTO: Decodable {
        public let leagueRecord: LeagueRecordDTO
        public let score: Int?
        public let isWinner: Bool?
        public let probablePitcher: PlayerDTO?
        public let team: EachTeamDTO
        
        enum CodingKeys: CodingKey {
            case leagueRecord
            case score
            case isWinner
            case probablePitcher
            case team
        }
    
        public struct EachTeamDTO: Decodable {
            public let id: Int
            public let abbreviation: String
            public let teamName: String
            public let locationName: String
            public let franchiseName: String
            
            enum CodingKeys: CodingKey {
                case abbreviation
                case teamName
                case locationName
                case id
                case franchiseName
            }
        }
        
        public struct LeagueRecordDTO: Decodable {
            public let wins: Int
            public let losses: Int
            public let pct: String
        
            enum CodingKeys: CodingKey {
                case wins
                case losses
                case pct
            }
        }
    }
}

public struct DecisionsDTO: Decodable {
    public let winner: PlayerDTO
    public let loser: PlayerDTO
    public let save: PlayerDTO?
    
    enum CodingKeys: CodingKey {
        case winner
        case loser
        case save
    }
}

public struct InningTeamDTO: Decodable {
    public let runs: Int?
    public let hits: Int?
    public let errors: Int?
    
    enum CodingKeys: CodingKey {
        case runs
        case hits
        case errors
    }
}

public struct InningDTO: Decodable {
    public let num: Int
    public let ordinalNum: String
    public let away: InningTeamDTO
    public let home: InningTeamDTO
    
    enum CodingKeys: CodingKey {
        case num
        case ordinalNum
        case away
        case home
    }
}

public struct LineScoreTeamsDTO: Decodable {
    public let away: InningTeamDTO
    public let home: InningTeamDTO
    
    enum CodingKeys: CodingKey {
        case away
        case home
    }
}

public struct DefenseDTO: Decodable {
    public let pitcher: LivePlayerDTO.PlayerPersonDTO?

    
    enum CodingKeys: CodingKey {
        case pitcher
    }
}

public struct OffenseDTO: Decodable {
    public let batter: LivePlayerDTO.PlayerPersonDTO?
    public let first: LivePlayerDTO.PlayerPersonDTO?
    public let second: LivePlayerDTO.PlayerPersonDTO?
    public let third: LivePlayerDTO.PlayerPersonDTO?
    public let onDeck: LivePlayerDTO.PlayerPersonDTO?
    
    enum CodingKeys: CodingKey {
        case batter
        case onDeck
        case first
        case second
        case third
    }
}

public struct LineScoreDTO: Decodable {
    public let currentInning: Int?
    public let currentInningOrdinal: String?
    public let inningState: String?
    public let innings: [InningDTO]
    public let teams: LineScoreTeamsDTO
    public let offense: OffenseDTO
    public let defense: DefenseDTO
    
    public let balls: Int?
    public let strikes: Int?
    public let outs: Int?
    
    enum CodingKeys: CodingKey {
        case currentInning
        case currentInningOrdinal
        case inningState
        case innings
        case teams
        case offense
        case defense
        case balls
        case strikes
        case outs
    }
}


public struct GameDTO: Decodable {
    public let gamePk: Int
    public let gameDate: String
    public let status: StatusDTO
    public let teams: TeamsDTO
    public let decisions: DecisionsDTO?
    public let linescore: LineScoreDTO?
    
    enum CodingKeys: CodingKey {
        case gamePk
        case gameDate
        case status
        case teams
        case decisions
        case linescore
    }
}


public struct ScheduleDTO: Decodable {
    public let games: [GameDTO]
    public let date: String?
    
    enum CodingKeys: CodingKey {
        case games
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.games = try container.decode([GameDTO].self, forKey: .games)
        self.date = self.games.first?.gameDate
    }
}


public struct MLBScheduleDTO: Decodable {
    public let dates: [ScheduleDTO]
    
    enum CodingKeys: CodingKey {
        case dates
    }
}
