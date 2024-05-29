import Foundation

public struct PitcherStatsDTO: Decodable {
    let summary: String?
    let inningsPitched: String?
    let hits: Int?
    let runs: Int?
    let earnedRuns: Int?
    let baseOnBalls: Int?
    let strikeOuts: Int?
    let homeRuns: Int?
    
    let era: String?
    
    enum CodingKeys: CodingKey {
        case summary
        case inningsPitched
        case hits
        case runs
        case earnedRuns
        case baseOnBalls
        case strikeOuts
        case homeRuns
        
        case era
    }
}

public struct BattingStateDTO: Decodable {
    let summary: String?
    let runs: Int?
    let homeRuns: Int?
    let atBats: Int?
    let strikeOuts: Int?
    let hits: Int?
    let rbi: Int?
    let baseOnBalls: Int?
    let leftOnBase: Int?
    
    let avg: String?
    let ops: String?
    
    enum CodingKeys: CodingKey {
        case summary
        case atBats
        case runs
        case homeRuns
        case strikeOuts
        case hits
        case rbi
        case leftOnBase
        case baseOnBalls
        
        case avg
        case ops
    }
}

public struct PlayerStatsDTO: Decodable {
    public let batting: BattingStateDTO?
    public let pitching: PitcherStatsDTO?
    
    enum CodingKeys: CodingKey {
        case batting
        case pitching
    }
}

public struct LivePlayerDTO: Decodable {
    public let person: PlayerPersonDTO
    public let battingOrder: String?
    public let stats: PlayerStatsDTO
    public let seasonStats: PlayerStatsDTO
    
    enum CodingKeys: CodingKey {
        case person
        case battingOrder
        case stats
        case seasonStats
    }
    
    public struct PlayerPersonDTO: Decodable {
        public let id: Int
        public let fullName: String
        
        enum CodingKeys: CodingKey {
            case id
            case fullName
        }
    }
}
