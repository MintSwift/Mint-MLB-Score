import Foundation
import SwiftDate

struct WidgetProvider {
    static func fetch(teamId: Int?) async -> (Game?, TeamStandings?, TeamStandings?) {
        let items = await TeamScheduleProvider.fetch(teamId: teamId ?? 119)
        let dates = items.map { DateSection($0) }
        
        let standings = await StandingsProvider.fetch()
        
        if let liveGame = dates.flatMap({ $0.games }).first(where: { $0.state == .live }) {
            // 라이브 진행중인 게임
            print("라이브")
            let awayID = liveGame.away.teamID
            let homeID = liveGame.home.teamID
            
            let awayStanding = standings.first(where: { $0.number == Int(awayID) })
            let homeStanding = standings.first(where: { $0.number == Int(homeID) })
            return (liveGame, awayStanding, homeStanding )
            
        } else {
            let finalGame = dates.flatMap { $0.games }.last(where: { $0.state == .final })
            let games = dates.flatMap { $0.games }.first(where: { $0.date.isInFuture })

            if finalGame?.date.dateByAdding(5, .hour).date ?? .now < Date.now {
                print("미래 게임")
                
                let awayID = games?.away.teamID
                let homeID = games?.home.teamID
                
                let awayStanding = standings.first(where: { $0.number == Int(awayID ?? "" ) })
                let homeStanding = standings.first(where: { $0.number == Int(homeID ?? "" ) })
                return (games, awayStanding, homeStanding)
            } else {
                print("지난게임")
                let awayID = finalGame?.away.teamID
                let homeID = finalGame?.home.teamID
                
                let awayStanding = standings.first(where: { $0.number == Int(awayID ?? "" ) })
                let homeStanding = standings.first(where: { $0.number == Int(homeID ?? "" ) })
                return (finalGame, awayStanding, homeStanding)
            }
        }
    }
}
