import Foundation

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
