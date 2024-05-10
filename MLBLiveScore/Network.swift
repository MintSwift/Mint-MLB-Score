import Foundation
import SwiftDate

struct Network {
    static func schedule(startDate: Date) async -> [Schedule] {
        let start = DateInRegion(startDate, region: .UTC).toFormat("MM/dd/yyyy")
        
        let end = DateInRegion(.now, region: .UTC).dateByAdding(2, .day).dateAtStartOf(.day).toFormat("MM/dd/yyyy")
        print(start)
        print(end)
        do {
//            hydrate=team(league),venue(location,timezone),linescore(matchup,runners,positions),decisions,homeRuns,probablePitcher,flags,review,seriesStatus,person,stats,broadcasts(all)
            let endPoint = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(start)&endDate=\(end)&sportId=1&hydrate=team(league),venue(location,timezone),linescore(matchup,runners,positions),decisions,homeRuns,probablePitcher,flags,review,seriesStatus,person,stats,broadcasts(all)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: endPoint)!
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
                        
            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
            let dic = json?["dates"] as? [Any] ?? []
           
            var schedules: [Schedule] = []
            
            for date in dic {
                
                var gameDates: [GameDate] = []
                let dicDate = date as? [String: Any] ?? [:]
                if let date = dicDate["date"] as? String {
                    
                    let games = dicDate["games"] as? [[String: Any]] ?? []
                    var gs: [Game] = []
                    
                    for game in games {
                        let gamed = game["gameDate"] as? String
                        
                        let teams = game["teams"] as? [String: Any] ?? [:]
//                        print("Teams: \(teams)")
                        let status = game["status"] as? [String: Any] ?? [:]
                        let abstractGameState = status["abstractGameState"] as? String ?? ""
                        
                        let reason = status["reason"] as? String
                        
                        
                        let homeTeamInfo = teams["home"] as? [String: Any] ?? [:]
                        let homeTeam = homeTeamInfo["team"] as? [String: Any] ?? [:]
                        let homeTeamName = homeTeam["clubName"] as? String ?? ""
                        let homeTeamNamefirst = homeTeam["franchiseName"] as? String ?? ""
                        let homeAbbreviation = (homeTeam["abbreviation"] as? String ?? "").lowercased().replacingOccurrences(of: "az", with: "ari")
                        let awayTeamInfo = teams["away"] as? [String: Any] ?? [:]

                        let awayTeam = awayTeamInfo["team"] as? [String: Any] ?? [:]
                        let awayTeamName = awayTeam["clubName"] as? String ?? ""
                        let awayTeamNameFirst = awayTeam["franchiseName"] as? String ?? ""
                        let awayAbbreviation = (awayTeam["abbreviation"] as? String ?? "").lowercased().replacingOccurrences(of: "az", with: "ari")
//                        print(teams)
                        
                        let linescore = game["linescore"] as? [String: Any] ?? [:]
                        let isTopInning = linescore["isTopInning"] as? Bool ?? false
                        let currentInning = linescore["currentInning"] as? Int ?? 0
                        let teamsResult = linescore["teams"] as? [String: Any] ?? [:]
                        let away = teamsResult["away"] as? [String: Any] ?? [:]
                        let home = teamsResult["home"] as? [String: Any] ?? [:]
                        let awayScore = away["runs"] as? Int ?? 0
                        let homeScore = home["runs"] as? Int ?? 0
                        let homeObject = Team(score: homeScore, locationName: homeTeamNamefirst, clubName: homeTeamName, symbol: homeAbbreviation)
                        let awayObject = Team(score: awayScore, locationName: awayTeamNameFirst, clubName: awayTeamName, symbol: awayAbbreviation)
                        
                        let game = Game(
                            currentInning: currentInning,
                            isTopInning: isTopInning,
                            away: awayObject,
                            home: homeObject,
                            state: abstractGameState,
                            reason: reason,
                            date: gamed?.toISODate(region: .UTC)?.date
                        )
                        gs.append(game)
                        
                    }
                    
                    gameDates.append(GameDate(date: date, games: gs))
                }
                
                schedules.append(Schedule(dates: gameDates))
            }
            
            return schedules
            
//            let firstDate = dic.first as? [String: Any]
//            let games = firstDate?["games"] as? Array<Any>
//            let firstGame = games?.first as? [String: Any]
//            let linescore = firstGame?["linescore"] as? [String: Any]
//            print(linescore)
//            let isTopInning = linescore?["isTopInning"] as? Bool
//            let currentInning = linescore?["currentInning"] as? Int
//            print(currentInning)
//            
//            let teamsResult = linescore?["teams"] as? [String: Any]
//            let away = teamsResult?["away"] as? [String: Any]
//            let home = teamsResult?["home"] as? [String: Any]
//            
//            let awayScore = away?["runs"] as? Int
//            let homeScore = home?["runs"] as? Int
//            print(awayScore)
//            print(homeScore)
//            print(schedule)
            
        } catch {
            print(error)
            return []
        }
        
    }
    
    
//    static func base() async -> ScoreResponse? {
//        do {
//            let endPoint = "https://statsapi.mlb.com/api/v1.1/game/746562/feed/live?fields=gameData,teams,teamName,shortName,status,abstractGameState,liveData,linescore,innings,num,home,away,runs,hits,errors".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let url = URL(string: endPoint)!
//            let response = try await URLSession.shared.data(from: url)
//            let data = response.0
//            let decoder = JSONDecoder()
//            let score = try decoder.decode(ScoreResponse.self, from: data)
//            return score
//            
//        } catch {
//            print(error)
//            return nil
//        }
//    }
}
