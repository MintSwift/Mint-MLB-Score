import Foundation

public struct Teams: Equatable, Hashable {
    public let away: Team
    public let home: Team
    
    public init(away: Team, home: Team) {
        self.away = away
        self.home = home
    }
    
    public struct Team: Equatable, Hashable {
        public let leagueRecord: LeagueRecord
        public let score: Int?
        public let isWinner: Bool?
        public let probablePitcher: Player?
        public let team: EachTeam
        
        public init(leagueRecord: LeagueRecord, score: Int?, isWinner: Bool?, probablePitcher: Player?, team: EachTeam) {
            self.leagueRecord = leagueRecord
            self.score = score
            self.isWinner = isWinner
            self.probablePitcher = probablePitcher
            self.team = team
        }
        
        public struct EachTeam: Equatable, Hashable {
            public let id: Int
            public let abbreviation: String
            public let teamName: String
            public let locationName: String
            public let franchiseName: String
            public let leagueName: String
            public let leagueAbbreviation: String
            
            public init(id: Int, abbreviation: String, teamName: String, locationName: String, franchiseName: String, leagueName: String, leagueAbbreviation: String) {
                self.id = id
                self.abbreviation = abbreviation
                self.teamName = teamName
                self.locationName = locationName
                self.franchiseName = franchiseName
                self.leagueName = leagueName
                self.leagueAbbreviation = leagueAbbreviation
            }
        }
        
        public struct LeagueRecord: Equatable, Hashable {
            public let wins: Int
            public let losses: Int
            public let pct: String
            
            public init(wins: Int, losses: Int, pct: String) {
                self.wins = wins
                self.losses = losses
                self.pct = pct
            }
        }
    }
}
