import Foundation
import SwiftDate

struct TeamScheduleProvider {
    static func fetch(teamId: Int) async -> [GameRespone] {
        let today = Date.now
        let startDate = today - 2.days
        
        let start = DateInRegion(startDate, region: .UTC).toFormat("MM/dd/yyyy")
        let end = DateInRegion(today, region: .UTC).dateByAdding(14, .day).dateAtStartOf(.day).toFormat("MM/dd/yyyy")
        let endPoint = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(start)&endDate=\(end)&teamId=\(teamId)&sportId=1&hydrate=team(league),decisions,probablePitcher,linescore".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        do {
            print(endPoint)
            let url = URL(string: endPoint)!
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            
            let decoder = JSONDecoder()
            let mlbSchedule = try decoder.decode(MLBSchedule.self, from: data)
            let game = mlbSchedule.date.flatMap { $0.games }
            return game
        } catch {
            print(endPoint)
            print(error)
            return []
        }
        
    }
}
