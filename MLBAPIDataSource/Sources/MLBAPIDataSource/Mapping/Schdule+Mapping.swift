import Foundation
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
        Player.PlayerStats.Stats(summary: summary, era: era, wins: wins, losses: losses, saves: saves)
    }
}


extension PlayerDTO {
    func toDomain() -> Player {
        Player(number: id, fullName: fullName, stats: stats.map { $0.toDomain() })
    }
}

extension TeamsDTO.TeamDTO.EachTeamDTO {
    func toDomain() -> Teams.Team.EachTeam {
        Teams.Team.EachTeam(
            id: id,
            abbreviation: abbreviation,
            teamName: teamName,
            locationName: locationName,
            franchiseName: franchiseName,
            leagueName: league.name,
            leagueAbbreviation: league.abbreviation
        )
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

extension InningTeamDTO {
     func toDomain() -> InningTeam {
         InningTeam(runs: runs, hits: hits, errors: errors)
    }
}

extension InningDTO {
     func toDomain() -> Inning {
         Inning(num: num, ordinalNum: ordinalNum, away: away.toDomain(), home: home.toDomain())
    }
}

extension LineScoreTeamsDTO {
     func toDomain() -> LineScoreTeams {
         LineScoreTeams(away: away.toDomain(), home: home.toDomain())
    }
}

extension OffenseDTO {
     func toDomain() -> Offense {
         Offense(
            batter: batter?.toDomain(),
            first: first?.toDomain(),
            second: second?.toDomain(),
            third: third?.toDomain(),
            onDeck: onDeck?.toDomain()
         )
    }
}

extension DefenseDTO {
     func toDomain() -> Defense {
         Defense(pitcher: pitcher?.toDomain())
    }
}

extension LineScoreDTO {
     func toDomain() -> LineScore {
         LineScore(
            currentInning: currentInning,
            currentInningOrdinal: currentInningOrdinal,
            inningState: inningState,
            innings: innings.map { $0.toDomain() },
            teams: teams.toDomain(),
            offense: offense.toDomain(),
            defense: defense.toDomain(),
            count: BallCount(balls: balls, strikes: strikes, outs: outs)
         )
    }
}


extension GameDTO {
     func toDomain() -> Game {
         Game(gamePk: gamePk,
              type: gameType,
              gameDate: gameDate,
              status: status.toDomain(),
              teams: teams.toDomain(),
              decisions: decisions?.toDomain(),
              linescore: linescore?.toDomain(),
              description: description,
              seriesGameNumber: seriesGameNumber,
              ifNecessary: ifNecessary == "Y" ? false : true
         )
    }
}

extension StatusDTO {
    func toDomain() -> Status {
        Status(abstractGameState: abstractGameState,
               detailedState: detailedState,
               reason: reason)
    }
}
