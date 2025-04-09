import Foundation

public struct CurrentPlayDTO: Decodable {
    public let matchup: MatchupDTO
    
    enum CodingKeys: CodingKey {
        case matchup
    }
}

public struct MatchupDTO: Decodable {
    public let batter: LivePlayerDTO.PlayerPersonDTO
    public let pitcher: LivePlayerDTO.PlayerPersonDTO
    
    enum CodingKeys: CodingKey {
        case batter
        case pitcher
    }
}

