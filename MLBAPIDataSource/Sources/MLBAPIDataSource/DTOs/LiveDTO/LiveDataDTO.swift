import Foundation

public struct LiveDataDTO: Decodable {
    public let boxscore: BoxScoreDTO
    public let linescore: LineScoreDTO
    
    enum CodingKeys: CodingKey {
        case boxscore
        case linescore
    }
}
