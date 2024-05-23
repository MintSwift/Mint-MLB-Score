import Foundation

public struct StatusDTO: Decodable {
    public let abstractGameState: String
    public let detailedState: String
    
    enum CodingKeys: CodingKey {
        case abstractGameState
        case detailedState
    }
}

public struct PlayerDTO: Decodable {
    public let id: Int
    public let fullName: String

    enum CodingKeys: CodingKey {
        case id
        case fullName
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
            public let abbreviation: String
            public let teamName: String
            public let locationName: String
        
            enum CodingKeys: CodingKey {
                case abbreviation
                case teamName
                case locationName
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


public struct LineScoreDTO: Decodable {
    public let currentInning: Int
    public let currentInningOrdinal: String
    public let inningState: String?
    
    enum CodingKeys: CodingKey {
        case currentInning
        case currentInningOrdinal
        case inningState
    }
}


public struct GameDTO: Decodable {
    public let gamePk: Int
    public let gameDate: String
    public let status: StatusDTO
    public let teams: TeamsDTO
    public let decisions: DecisionsDTO?
    
    enum CodingKeys: CodingKey {
        case gamePk
        case gameDate
        case status
        case teams
        case decisions
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
