import Foundation

public struct StandingsTeam: Equatable, Hashable {
    public let id: Int
    public let name: String
    public let abbreviation: String
    public let division: Division
    
    public init(id: Int, name: String, abbreviation: String, division: Division) {
        self.id = id
        self.name = name
        self.abbreviation = abbreviation
        self.division = division
    }
}

public struct TeamRecords: Equatable, Hashable {
    public let team: StandingsTeam
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
    
    public init(team: StandingsTeam, divisionRank: String, leagueRank: String, sportRank: String, gamesBack: String, wildCardGamesBack: String, divisionGamesBack: String, wildCardRank: String?, wins: Int, losses: Int, winningPercentage: String) {
        self.team = team
        self.divisionRank = divisionRank
        self.leagueRank = leagueRank
        self.sportRank = sportRank
        self.gamesBack = gamesBack
        self.wildCardGamesBack = wildCardGamesBack
        self.divisionGamesBack = divisionGamesBack
        self.wildCardRank = wildCardRank
        self.wins = wins
        self.losses = losses
        self.winningPercentage = winningPercentage
    }

}

public struct Division: Equatable, Hashable {
    public let id: Int
    public let name: String?
    public let nameShort: String?
    public let abbreviation: String?
    
    public init(id: Int, name: String?, nameShort: String?, abbreviation: String?) {
        self.id = id
        self.name = name
        self.nameShort = nameShort
        self.abbreviation = abbreviation
    }
}

public struct StandingsRecord: Equatable, Hashable {
    public let division: Division
    public let teamRecords: [TeamRecords]
    
    public init(division: Division, teamRecords: [TeamRecords]) {
        self.division = division
        self.teamRecords = teamRecords
    }
}


public struct MLBStandings: Equatable, Hashable {
    public let records: [StandingsRecord]
    
    public init(records: [StandingsRecord]) {
        self.records = records
    }
}
