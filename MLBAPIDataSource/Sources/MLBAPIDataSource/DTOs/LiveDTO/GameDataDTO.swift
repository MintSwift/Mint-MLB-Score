import Foundation

public struct GamePlayersDTO: Decodable {
    public let id: Int
    public let fullName: String
    public let firstName: String
    public let lastName: String
    public let boxscoreName: String
    
    enum CodingKeys: CodingKey {
        case id
        case fullName
        case firstName
        case lastName
        case boxscoreName
    }
}

public struct GameDataDTO: Decodable {
    public let status: StatusDTO
    public let players: [String: GamePlayersDTO]
    
    enum CodingKeys: CodingKey {
        case status
        case players
    }
}
