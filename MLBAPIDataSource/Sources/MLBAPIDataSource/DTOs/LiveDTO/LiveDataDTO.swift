import Foundation

public struct LiveDataDTO: Decodable {
    public let boxscore: BoxScoreDTO
    
    enum CodingKeys: CodingKey {
        case boxscore
    }
}
