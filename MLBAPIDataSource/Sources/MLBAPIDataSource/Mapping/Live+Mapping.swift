import Foundation
import MLBDomain

extension BattingStateDTO {
    func toDomain() -> BattingState {
        BattingState(summary: summary, runs: runs, homeRuns: homeRuns, atBats: atBats, strikeOuts: strikeOuts, hits: hits, rbi: rbi, baseOnBalls: baseOnBalls, leftOnBase: leftOnBase, avg: avg, ops: ops)
    }
}

extension PitcherStatsDTO {
    func toDomain() -> PitcherStats {
        PitcherStats(summary: summary, inningsPitched: inningsPitched, hits: hits, runs: runs, earnedRuns: earnedRuns, baseOnBalls: baseOnBalls, strikeOuts: strikeOuts, homeRuns: homeRuns, era: era)
    }
}
extension PlayerStatsDTO {
    func toDomain() -> PlayerStats {
        PlayerStats(batting: batting?.toDomain(), pitching: pitching?.toDomain())
    }
}
extension LivePlayerDTO {
    func toDomain() -> LivePlayer {
        LivePlayer(person: person.toDomain(),
                   battingOrder: battingOrder,
                   stats: stats.toDomain(), seasonStats: seasonStats.toDomain())
    }
}
extension LivePlayerDTO.PlayerPersonDTO {
    func toDomain() -> LivePlayer.PlayerPerson {
        LivePlayer.PlayerPerson(id: id, fullName: fullName)
    }
}

extension LiveTeamDTO {
    func toDomain() -> LiveTeam {
        let players = players.mapValues { $0.toDomain() }
        let mappingBatters = batters.compactMap { players["ID\($0)"] }
        let mappingPitchers = pitchers.compactMap { players["ID\($0)"] }
        return LiveTeam(players: players, batters: mappingBatters, pitchers: mappingPitchers)
    }
}


extension LiveTeamsDTO {
    func toDomain() -> LiveTeams {
        LiveTeams(away: away.toDomain(), home: home.toDomain())
    }
}

extension BoxScoreDTO {
    func toDomain() -> BoxScore {
        BoxScore(teams: teams.toDomain())
    }
}

extension LiveDataDTO {
    func toDomain() -> LiveData {
        LiveData(boxscore: boxscore.toDomain(), linescore: linescore.toDomain())
    }
}

extension GamePlayersDTO {
    func toDomain() -> GamePlayers {
        GamePlayers(id: id, fullName: fullName, firstName: firstName, lastName: lastName, boxscoreName: boxscoreName)
    }
}

extension GameDataDTO {
    func toDomain() -> GameData {
        GameData(status: status.toDomain(), players: players.mapValues { $0.toDomain() } )
    }
}

extension MLBLiveDTO {
    func toDomain() -> Live {
        Live(gameData: gameData.toDomain(), liveData: liveData.toDomain())
    }
}
