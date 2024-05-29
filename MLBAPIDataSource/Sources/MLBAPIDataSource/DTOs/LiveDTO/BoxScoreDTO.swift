import Foundation


public struct LiveTeamDTO: Decodable {
    public let players: [String: LivePlayerDTO]
    public let batters: [Int]
    public let pitchers: [Int]
    
    enum CodingKeys: CodingKey {
        case players
        case batters
        case pitchers
    }
}

public struct LiveTeamsDTO: Decodable {
    public let away: LiveTeamDTO
    public let home: LiveTeamDTO
    
    enum CodingKeys: CodingKey {
        case away
        case home
    }
}

public struct BoxScoreDTO: Decodable {
    public let teams: LiveTeamsDTO
    
    enum CodingKeys: CodingKey {
        case teams
    }
}
