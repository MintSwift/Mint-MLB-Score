import Foundation

public struct MLBLiveDTO: Decodable {
    public let gameData: GameDataDTO
    public let liveData: LiveDataDTO
    
    enum CodingKeys: CodingKey {
        case gameData
        case liveData
    }
}
