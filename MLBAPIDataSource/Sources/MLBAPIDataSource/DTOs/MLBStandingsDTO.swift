import Foundation

public struct TeamRecordsDTO: Decodable {
    public let team: StandingsTeamDTO
    public let divisionRank: String
    public let leagueRank: String
    public let sportRank: String
    public let gamesBack: String
    public let wildCardGamesBack: String
    public let divisionGamesBack: String
    public let wildCardRank: String?
    
    public let wins: Int
    public let losses: Int
    public let winningPercentage: String
    
    enum CodingKeys: CodingKey {
        case divisionRank
        case leagueRank
        case sportRank
        case gamesBack
        case wildCardGamesBack
        case divisionGamesBack
        case wildCardRank
        
        case wins
        case losses
        case winningPercentage
        case team
    }
}

public struct StandingsTeamDTO: Decodable {
    public let id: Int
    public let name: String
    public let abbreviation: String
    public let division: StandingsDivisionDTO
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case abbreviation
        case division
    }
}

public struct StandingsRecordDTO: Decodable {
    public let division: StandingsDivisionDTO
    public let teamRecords: [TeamRecordsDTO]
    
    enum CodingKeys: CodingKey {
        case division
        case teamRecords
    }
}

public struct MLBStandingsDTO: Decodable {
    public let records: [StandingsRecordDTO]
    
    enum CodingKeys: CodingKey {
        case records
    }
}






public struct StandingsDivisionDTO: Decodable {
    public let id: Int
    public let name: String?
    public let nameShort: String?
    public let abbreviation: String?
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case nameShort
        case abbreviation   
    }
}
