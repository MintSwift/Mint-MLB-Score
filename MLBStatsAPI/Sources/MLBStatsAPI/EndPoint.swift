import Foundation
import SwiftDate

public enum League {
    case all
    case american
    case national
}

public enum EndPoint {
    case allSchedule
    case teamSchedule(teamId: Int)
    case pitcherStats(plyerId: String)
    case leagueStandings(league: League)
    case live(pk: String)
    case player(id: String)
    
    package func url() -> URL? {
        switch self {
        case .allSchedule:
            
            let start: Date
            let dateByAdding: Int

            let postSessionStart = "09/28/\(Date.now.year)".toDate("MM/dd/yyyy")?.date
            let postSessionEnd = "11/03/\(Date.now.year)".toDate("MM/dd/yyyy")?.date
            
            if let startP = postSessionStart, let endP = postSessionEnd {
                let isIn = Date.now.isInRange(date: startP, and: endP)
                
                if isIn {
                    start = Date.now
                    dateByAdding = 7
                } else {
                    if Date.now.hour >= 9 {
                        start = Date.now - 1.days
                        dateByAdding = 1
                    } else {
                        start = Date.now
                        dateByAdding = 0
                    }
                }
            } else {
                if Date.now.hour >= 9 {
                    start = Date.now - 1.days
                    dateByAdding = 1
                } else {
                    start = Date.now
                    dateByAdding = 0
                }
            }
            
//            if Date.now.month >= 9 && Date.now.day >= 28 {
//                start = Date.now - 1.days
//                dateByAdding = 7
//            } else if Date.now.hour >= 9 {
//                start = Date.now - 1.days
//                dateByAdding = 1
//            } else {
//                start = Date.now
//                dateByAdding = 0
//            }
            
            
            let standardDate = DateInRegion(start, region: .UTC).dateAtStartOf(.day)
            
            let startString = standardDate.toFormat("MM/dd/yyyy")
            let end = standardDate.dateByAdding(dateByAdding, .day).dateAtStartOf(.day).toFormat("MM/dd/yyyy")
            let endPoint = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(startString)&endDate=\(end)&sportId=1&hydrate=team(league),decisions,probablePitcher,linescore,stats(group=[pitching],type=season,sportId=1),currentTeam".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: endPoint)
            
            
        case .teamSchedule(let teamId):
            let today = Date.now
            let startDate = today - 30.days
            
            let start = DateInRegion(startDate, region: .UTC).toFormat("MM/dd/yyyy")
            let end = DateInRegion(today, region: .UTC).dateByAdding(10, .day).dateAtStartOf(.day).toFormat("MM/dd/yyyy")
            let endPoint = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(start)&endDate=\(end)&teamId=\(teamId)&sportId=1&hydrate=team(league),decisions,probablePitcher,linescore,stats(group=[pitching],type=season,sportId=1),currentTeam".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: endPoint)
            
        case .pitcherStats(let plyerId):
            let endPoint = "https://statsapi.mlb.com/api/v1/people/\(plyerId)?hydrate=stats(group=[pitching],type=season,sportId=1),currentTeam".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: endPoint)
            
        case .leagueStandings(let league):
            var leagueId = "103,104"
            switch league {
            case .all:
                leagueId = "103,104"
            case .american:
                leagueId = "103"
            case .national:
                leagueId = "104"
            }
            let endPoint = "https://statsapi.mlb.com/api/v1/standings?leagueId=\(leagueId)&season=2025&standingsTypes=regularSeason&hydrate=team(division)&fields=records,standingsType,teamRecords,team,name,division,id,nameShort,abbreviation,divisionRank,gamesBack,wildCardRank,wildCardGamesBack,wildCardEliminationNumber,divisionGamesBack,clinched,eliminationNumber,winningPercentage,type,wins,losses,leagueRank,sportRank".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: endPoint)
            
        case .live(let pk):
            let endPoint = "https://statsapi.mlb.com/api/v1.1/game/\(pk)/feed/live".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: endPoint)
        case .player(id: let id):
            
            let endPoint =
            "https://statsapi.mlb.com/api/v1/people/\(id)?hydrate=stats(group=%5Bhitting%5D,type=season,sportId=1),currentTeam"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            return URL(string: endPoint)
        }
    }
}

