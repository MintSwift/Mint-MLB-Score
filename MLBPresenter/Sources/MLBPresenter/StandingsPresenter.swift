import Foundation
import MLBDomain
import SwiftDate

public struct TeamInfoPresenter: Equatable, Hashable {
    public let id: Int
    public let name: String
    public let abbreviation: String
    public let division: Division
    
    public init(_ team: StandingsTeam) {
        self.id = team.id
        self.division = team.division
        self.name = team.name
        self.abbreviation = team.abbreviation
    }

}

public struct TeamRecordPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    
    public let team: TeamInfoPresenter
    public let teamNameDivision: String
    public let teamName: String
    
    public let divisionRank: String
    public let leagueRank: String
    public let sportRank: String
    public let gamesBack: String
    public let wildCardGamesBack: String
    public let divisionGamesBack: String
    
    public let wins: String
    public let losses: String
    public let winningPercentage: String
    
    public init(_ records: TeamRecords) {
        id = UUID().uuidString
        
        self.divisionRank = records.divisionRank
        self.leagueRank = records.leagueRank
        self.sportRank = records.sportRank
        self.gamesBack = records.gamesBack
        self.wildCardGamesBack = records.wildCardGamesBack
        self.divisionGamesBack = records.divisionGamesBack
        
        self.wins = String(records.wins)
        self.losses = String(records.losses)
        self.winningPercentage = records.winningPercentage
        self.team = TeamInfoPresenter(records.team)
        
        self.teamName = records.team.name
        if let last = records.team.division.abbreviation?.last {
            self.teamNameDivision = "\(records.team.name) - \(last)"
        } else {
            self.teamNameDivision = records.team.name
        }
    }

}

public struct DivisionPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var title: String
    public var leaders: [TeamRecordPresenter]
    
    init(title: String, leaders: [TeamRecordPresenter]) {
        self.id = UUID().uuidString
        self.title = title
        self.leaders = leaders
    }
}


public struct LeaguePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var east: [TeamRecordPresenter]
    public var central: [TeamRecordPresenter]
    public var west: [TeamRecordPresenter]
    
    public var wildcardRank: [DivisionPresenter]
    
    public var divisionLeaders: [TeamRecordPresenter]
    public var wildCardRankTop: [TeamRecordPresenter]
    public var wildCardRankBottom: [TeamRecordPresenter]
    
    public init(_ records: [TeamRecords]) {
        id = UUID().uuidString
        
        self.west = records
            .filter { $0.team.division.name?.contains("West") == true }
            .map { TeamRecordPresenter($0) }
        
        self.central = records
            .filter { $0.team.division.name?.contains("Central") == true }
            .map { TeamRecordPresenter($0) }
        
        self.east = records
            .filter { $0.team.division.name?.contains("East") == true }
            .map { TeamRecordPresenter($0) }
        
        
        let divisionLeaders = records
            .filter { $0.divisionRank == "1" }
            .sorted(by: { $0.winningPercentage > $1.winningPercentage })
            .map { TeamRecordPresenter($0) }
        
        self.divisionLeaders = divisionLeaders
        
        let wildCardRank = records
            .sorted(by: { Int($0.wildCardRank ?? "90") ?? 90 < Int($1.wildCardRank ?? "90") ?? 90 })
            .map { TeamRecordPresenter($0) }
        
        self.wildCardRankTop = Array(wildCardRank.prefix(3))
        
        let bottoms = wildCardRank.dropFirst(3)
        let others = bottoms.dropLast(3)
        
        self.wildCardRankBottom = Array( others )
        
        self.wildcardRank = [
            DivisionPresenter(title: "AL Leader", leaders: divisionLeaders),
            DivisionPresenter(title: "AL Wild Card", leaders: wildCardRankTop),
            DivisionPresenter(title: "American League", leaders: wildCardRankBottom),
        ]
    }
}


public struct StandingsPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var american: LeaguePresenter
    public var national: LeaguePresenter
    
    public init(_ standings: MLBStandings) {
        id = UUID().uuidString
         
        let all = standings.records
            .flatMap { $0.teamRecords }
        
        let american = all.filter { $0.team.division.name?.hasPrefix("American") == true }
        self.american = LeaguePresenter(american)
        
        let national = all.filter { $0.team.division.name?.hasPrefix("National") == true }
        self.national = LeaguePresenter(national)
    }
    
    public static func create(_ standings: MLBStandings) -> StandingsPresenter {
        return StandingsPresenter(standings)
    }
}
