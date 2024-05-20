import Foundation
import SwiftDate

public struct MLBStatusResponse: Decodable {
    let abstractGameState: String
    let detailedState: String
    
    enum CodingKeys: CodingKey {
        case abstractGameState
        case detailedState
    }
}

public struct MLBPlayerResponse: Decodable {
    let id: Int
    let fullName: String

    enum CodingKeys: CodingKey {
        case id
        case fullName
    }
}

public struct MLBTeamsResponse: Decodable {
    let away: MLBTeamResponse
    let home: MLBTeamResponse
    
    enum CodingKeys: CodingKey {
        case away
        case home
    }
    
    public struct MLBTeamResponse: Decodable {
        let leagueRecord: MLBLeagueRecordResponse
        let score: Int?
        let isWinner: Bool?
        let probablePitcher: MLBPlayerResponse?
        let team: MLBEachTeamResponse
        
        enum CodingKeys: CodingKey {
            case leagueRecord
            case score
            case isWinner
            case probablePitcher
            case team
        }
        
        
        
        public struct MLBEachTeamResponse: Decodable {
            let abbreviation: String
            let teamName: String
            let locationName: String
        
            enum CodingKeys: CodingKey {
                case abbreviation
                case teamName
                case locationName
            }
        }
        
        public struct MLBLeagueRecordResponse: Decodable {
            let wins: Int
            let losses: Int
            let pct: String
        
            enum CodingKeys: CodingKey {
                case wins
                case losses
                case pct
            }
        }
    }
}

public struct MLBDecisionsResponse: Decodable {
    let winner: MLBPlayerResponse
    let loser: MLBPlayerResponse
    let save: MLBPlayerResponse?
    
    enum CodingKeys: CodingKey {
        case winner
        case loser
        case save
    }
}


public struct MLBLinescoreResponse: Decodable {
    let currentInning: Int
    let currentInningOrdinal: String
    let inningState: String?
    
    enum CodingKeys: CodingKey {
        case currentInning
        case currentInningOrdinal
        case inningState
    }
}


public struct MLBGameResponse: Decodable {
    let gamePk: Int
    let gameDate: String
    let status: MLBStatusResponse
    let teams: MLBTeamsResponse
    let decisions: MLBDecisionsResponse?
    
    enum CodingKeys: CodingKey {
        case gamePk
        case gameDate
        case status
        case teams
        case decisions
    }
}


public struct MLBDateResponse: Decodable {
    let games: [MLBGameResponse]
    let date: Date
    
    enum CodingKeys: CodingKey {
        case games
        case date
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.games = try container.decode([MLBGameResponse].self, forKey: .games)
        let date = try container.decode(String.self, forKey: .date)
        
        
        let arraydate =  date.toDate(region: .UTC)?.date ?? .now
        print("Date", arraydate)
        let currentDate =  self.games.first?.gameDate.toDate(region: .UTC)?.date ?? .now
        print("GameDate",currentDate)
        self.date = currentDate
    }
}


public struct MLBScheduleResponse: Decodable {
    let dates: [MLBDateResponse]
    
    enum CodingKeys: CodingKey {
        case dates
    }
}
