import Foundation
import MLBDomain

extension StandingsDivisionDTO {
    func toDomain() -> Division {
        Division(id: id, name: name, nameShort: nameShort, abbreviation: abbreviation)
    }
}

extension StandingsTeamDTO {
    func toDomain() -> StandingsTeam {
        StandingsTeam(id: id, name: name, abbreviation: abbreviation, division: division.toDomain())
    }
}

extension TeamRecordsDTO {
    func toDomain() -> TeamRecords {
        TeamRecords(team: team.toDomain(),
                    divisionRank: divisionRank,
                    leagueRank: leagueRank,
                    sportRank: sportRank,
                    gamesBack: gamesBack,
                    wildCardGamesBack: wildCardGamesBack,
                    divisionGamesBack: divisionGamesBack,
                    wildCardRank: wildCardRank,
                    wins: wins,
                    losses: losses,
                    winningPercentage: winningPercentage)
    }
}

extension StandingsRecordDTO {
    func toDomain() -> StandingsRecord {
        StandingsRecord(division: division.toDomain(),
                        teamRecords: teamRecords.map { $0.toDomain() })
    }
}

extension MLBStandingsDTO {
    func toDomain() -> MLBStandings {
        MLBStandings(records: records.map { $0.toDomain() })
    }
}
