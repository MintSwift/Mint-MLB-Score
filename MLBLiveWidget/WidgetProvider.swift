import Foundation
import SwiftDate

struct GameInfo {
    let game: Game?
    let awayTeamStandings: TeamStandings?
    let homeTeamStandings: TeamStandings?
    
    let winnerPlayerRecord: PitcherPerson?
    let loserPlayerRecord: PitcherPerson?
}

struct WidgetProvider {
    static func fetch(teamId: Int?) async -> (GameInfo?) {
        let items = await TeamScheduleProvider.fetch(teamId: teamId ?? 135)
        let dates = items.map { DateSection($0) }
        let standings = await StandingsProvider.fetch(leagueId: "103,104")

        if let liveGame = dates.flatMap({ $0.games }).first(where: { $0.state == .live }) {
            // 라이브 진행중인 게임
            print("라이브")
            let awayID = liveGame.away.teamID
            let homeID = liveGame.home.teamID
            
            let awayStanding = standings.first(where: { $0.number == Int(awayID) })
            let homeStanding = standings.first(where: { $0.number == Int(homeID) })
            
            let info = GameInfo(game: liveGame, awayTeamStandings: awayStanding, homeTeamStandings: homeStanding, winnerPlayerRecord: nil, loserPlayerRecord: nil)
            return info
            
        } else {
            let finalGame = dates.flatMap { $0.games }.last(where: { $0.state == .final })
            let games = dates.flatMap { $0.games }.first(where: { $0.date.isInFuture })
        
            if finalGame?.date.dateByAdding(5, .hour).date ?? .now < Date.now {
                print("미래 게임")
                
                let awayID = games?.away.teamID
                let homeID = games?.home.teamID
                
                let awayStanding = standings.first(where: { $0.number == Int(awayID ?? "" ) })
                let homeStanding = standings.first(where: { $0.number == Int(homeID ?? "" ) })
                
                let finalGameWin = games?.away.probablePitcher.number
                let finalGamelose = games?.home.probablePitcher.number
                let winnerPitcherRecord = await PitchingProvider.fetch(id: finalGameWin ?? "1")
                let loserPitcherRecord = await PitchingProvider.fetch(id: finalGamelose ?? "1")
                
                let info = GameInfo(game: games, awayTeamStandings: awayStanding, homeTeamStandings: homeStanding, winnerPlayerRecord: winnerPitcherRecord, loserPlayerRecord: loserPitcherRecord)
                
                return info
            } else {
                print("지난게임")
                let awayID = finalGame?.away.teamID
                let homeID = finalGame?.home.teamID
                
                let awayStanding = standings.first(where: { $0.number == Int(awayID ?? "" ) })
                let homeStanding = standings.first(where: { $0.number == Int(homeID ?? "" ) })
                
                
                let finalGameWin = finalGame?.winnerPitcher?.number
                let finalGamelose = finalGame?.loserPitcher?.number
                let winnerPitcherRecord = await PitchingProvider.fetch(id: finalGameWin ?? "1")
                let loserPitcherRecord = await PitchingProvider.fetch(id: finalGamelose ?? "1")
                
                let info = GameInfo(game: finalGame, awayTeamStandings: awayStanding, homeTeamStandings: homeStanding, winnerPlayerRecord: winnerPitcherRecord, loserPlayerRecord: loserPitcherRecord)
                
                return info
            }
        }
    }
}


extension WidgetProvider {
    static func standings(league: Int) async -> ([TeamStandings], [TeamStandings]) {
        let leagueId = league == 0 ? "103,104" : league == 1 ? "103" : "104"
        let standings = await StandingsProvider.fetch(leagueId: leagueId)
        let leagueName = league == 1 ? "AL" : "NL"
        let ALDivisionLeaders = standings.filter({ team in
            return team.divisionShortName.hasPrefix(leagueName) && team.divisionRank == "1"
        }).sorted(by: { $0.winningPercentage > $1.winningPercentage })
        
        let wildCards = standings.filter({ team in
            return team.divisionShortName.hasPrefix(leagueName)
        }).sorted(by: { Int($0.wildCardRank ?? "90") ?? 90 < Int($1.wildCardRank ?? "90") ?? 90 })
        
        let wildCardRanks = Array( wildCards.prefix(6) )
          
        return (ALDivisionLeaders, wildCardRanks)
    }
}
