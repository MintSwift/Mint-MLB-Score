import Foundation

public struct Player: Equatable, Hashable {
    public let number: Int
    public let fullName: String
    public let stats: [PlayerStats]
    
    public init(number: Int, fullName: String, stats: [PlayerStats]) {
        self.number = number
        self.fullName = fullName
        self.stats = stats
    }
    
    public struct PlayerStats: Equatable, Hashable {
        public let group: StatsGroup // hitting, pitching
        public let type: StatsGroup // statsSingleSeason, gameLog
        public let stats: Stats

        public init(group: StatsGroup, type: StatsGroup, stats: Stats) {
            self.group = group
            self.type = type
            self.stats = stats
        }
        
        public struct Stats: Equatable, Hashable {
            public let summary: String?
            public let era: String?
            
            public let wins: Int?
            public let losses: Int?
            public init(summary: String?, era: String?, wins: Int?, losses: Int?) {
                self.summary = summary
                self.era = era
                self.wins = wins
                self.losses = losses
            }
        }
        
        public struct StatsGroup: Equatable, Hashable {
            public let displayName: String
            
            public init(displayName: String) {
                self.displayName = displayName
            }
        }
    }
}
