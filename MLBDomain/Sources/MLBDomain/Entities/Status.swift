import Foundation

public enum GameStatus: String, Codable {
    case final = "Final"
    case live = "Live"
    case preview = "Preview"
    case warmup = "Warmup"
    case inProgress = "In Progress"
    case scheduled = "Scheduled"
    case preGame = "Pre-Game"
    case postponed = "Postponed"
    case unknown
}


public struct Status: Equatable, Hashable {
    public let abstractGameState: String
    public let detailedState: String
    public let reason: String?
    
    public init(abstractGameState: String, detailedState: String, reason: String?) {
        self.abstractGameState = abstractGameState
        self.detailedState = detailedState
        self.reason = reason
    }
}
