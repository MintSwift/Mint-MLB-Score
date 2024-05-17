import Foundation
import SwiftDate

struct WidgetProvider {
    static func fetch(teamId: Int?) async -> [Game] {
        let items = await TeamScheduleProvider.fetch(teamId: teamId ?? 119)
        let dates = items.map { DateSection($0) }
        let finalGame = dates.flatMap { $0.games }.last(where: { $0.state == .final })
        var newGames: [Game] = []
        if let liveGame = dates.flatMap({ $0.games }).first(where: { $0.state == .live }) {
            // 라이브 진행중인 게임
            newGames.append(liveGame)
        } else {
            let games = dates.flatMap { $0.games }.first(where: { $0.date.isInFuture })
            if let finalGame {
                newGames.append(finalGame)
            }
            
            if let games {
                newGames.append(games)
            }
        }
        
    
        print(newGames.map { $0.date.toString() })
        
        return Array( newGames )
    }
}
