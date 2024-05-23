import Foundation
import MLBAPIDataSource
import MLBDomain

extension MLBScheduleDTO {
     func toDomain() -> MLBPlan {
         MLBPlan(schedules: dates.map { $0.toDomain() })
     }
}

extension ScheduleDTO {
     func toDomain() -> Schedule {
         Schedule(games: games.map { $0.toDomain() }, date: date)
    }
}

extension TeamsDTO.TeamDTO.LeagueRecordDTO {
    func toDomain() -> Teams.Team.LeagueRecord {
        Teams.Team.LeagueRecord(wins: wins, losses: losses, pct: pct)
    }
}

extension PlayerDTO.PlayerStatsDTO {
    func toDomain() -> Player.PlayerStats {
        Player.PlayerStats(group: group.toDomain(),
                           type: type.toDomain(),
                           stats: stats.toDomain())
    }
}

extension PlayerDTO.PlayerStatsDTO.StatsGroupDTO {
    func toDomain() -> Player.PlayerStats.StatsGroup {
        Player.PlayerStats.StatsGroup(displayName: displayName)
    }
}
extension PlayerDTO.PlayerStatsDTO.StatsDTO {
    func toDomain() -> Player.PlayerStats.Stats {
        Player.PlayerStats.Stats(summary: summary, era: era, wins: wins, losses: losses)
    }
}


extension PlayerDTO {
    func toDomain() -> Player {
        Player(number: id, fullName: fullName, stats: stats.map { $0.toDomain() })
    }
}

extension TeamsDTO.TeamDTO.EachTeamDTO {
    func toDomain() -> Teams.Team.EachTeam {
        Teams.Team.EachTeam(abbreviation: abbreviation, teamName: teamName, locationName: locationName)
    }
}

extension TeamsDTO.TeamDTO {
    func toDomain() -> Teams.Team {
        Teams.Team(leagueRecord: leagueRecord.toDomain(), score: score, isWinner: isWinner, probablePitcher: probablePitcher?.toDomain(), team: team.toDomain())
    }
}

extension TeamsDTO {
     func toDomain() -> Teams {
         Teams(away: away.toDomain(), home: home.toDomain())
    }
}

extension DecisionsDTO {
     func toDomain() -> Decisions {
         Decisions(winner: winner.toDomain(), loser: loser.toDomain(), save: save?.toDomain())
    }
}

extension GameDTO {
     func toDomain() -> Game {
         Game(gamePk: gamePk,
              gameDate: gameDate,
              status: status.toDomain(),
              teams: teams.toDomain(),
              decisions: decisions?.toDomain())
    }
}

extension StatusDTO {
     func toDomain() -> Status {
         Status(abstractGameState: abstractGameState,
                detailedState: detailedState,
                reason: reason)
    }
}
