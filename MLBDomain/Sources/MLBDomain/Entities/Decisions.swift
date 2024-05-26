import Foundation

public struct Decisions: Equatable, Hashable {
    public let winner: Player
    public let loser: Player
    public let save: Player?
    
    public init(winner: Player, loser: Player, save: Player?) {
        self.winner = winner
        self.loser = loser
        self.save = save
    }
}
