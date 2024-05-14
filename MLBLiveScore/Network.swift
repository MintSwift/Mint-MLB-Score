//import Foundation
//import SwiftDate
//
//struct Network {
//    static func live(id: String) async -> LiveScore? {
//        do {
//            let endPoint = "https://statsapi.mlb.com/api/v1.1/game/\(id)/feed/live".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let url = URL(string: endPoint)!
//            let response = try await URLSession.shared.data(from: url)
//            let data = response.0
//            
//            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] ?? [:]
//            print(json)
//            
//            let liveData = json["liveData"] as? [String: Any] ?? [:]
//            
//            let linescore = liveData["linescore"] as? [String: Any] ?? [:]
//            let gameData = liveData["gameData"] as? [String: Any] ?? [:]
//            
//            let boxscore = liveData["boxscore"] as? [String: Any] ?? [:]
//            
//            let teams = boxscore["teams"] as? [String: Any] ?? [:]
//            let awayList = teams["away"] as? [String: Any] ?? [:]
//            let awaybatters = awayList["batters"] as? [Int] ?? []
//            let awaypitchers = awayList["pitchers"] as? [Int] ?? []
//            let awayplayers = awayList["players"] as? [String: Any] ?? [:]
//
//            var battersInfomations: [BatterBox] = []
//            for awaybatter in awaybatters {
//                let player = awayplayers["ID\(awaybatter)"] as? [String: Any] ?? [:]
//                
//                let person = player["person"] as? [String: Any] ?? [:]
//                let name = person["fullName"] as? String ?? ""
//                let id = person["id"] as? String ?? ""
//                
//                let seasonStats = player["seasonStats"] as? [String: Any] ?? [:]
//                let batting = seasonStats["batting"] as? [String: Any] ?? [:]
//                let avg = batting["avg"] as? String ?? ".000"
//                let ops = batting["ops"] as? String ?? ".000"
//                
//                let stats = player["stats"] as? [String: Any] ?? [:]
//                let statsbatting = stats["batting"] as? [String: Any] ?? [:]
//                let ab = String( statsbatting["atBats"] as? Int ?? 0 )
//                let r = String( statsbatting["runs"] as? Int ?? 0 )
//                let h = String( statsbatting["hits"] as? Int ?? 0 )
//                let rbi = String( statsbatting["rbi"] as? Int ?? 0 )
//                let bb = String( statsbatting["baseOnBalls"] as? Int ?? 0 )
//                let k = String( statsbatting["strikeOuts"] as? Int ?? 0 )
//                let lob = String( statsbatting["leftOnBase"] as? Int ?? 0 )
//                let battingOrder = player["battingOrder"] as? String ?? "0"
//
//                let batterBox = BatterBox(name: name, number: id, battingOrder: Int(battingOrder) ?? 0, ab: ab, r: r, h: h, rbi: rbi, bb: bb, k: k, lob: lob, avg: avg, ops: ops)
//                battersInfomations.append(batterBox)
//            }
//            
//            var pitcherInfomations: [PitcherBox] = []
//            for awaypitcher in awaypitchers {
//                let player = awayplayers["ID\(awaypitcher)"] as? [String: Any] ?? [:]
//                
//                let person = player["person"] as? [String: Any] ?? [:]
//                let name = person["fullName"] as? String ?? ""
//                let id = person["id"] as? String ?? ""
//                
//                let seasonStats = player["seasonStats"] as? [String: Any] ?? [:]
//                let pitching = seasonStats["pitching"] as? [String: Any] ?? [:]
//                let era = pitching["era"] as? String ?? "-.--"
//                
//                let stats = player["stats"] as? [String: Any] ?? [:]
//                let statspitching = stats["pitching"] as? [String: Any] ?? [:]
//                let ip = statspitching["inningsPitched"] as? String ?? "0.0"
//                let h = statspitching["hits"] as? String ?? "0"
//                let r = statspitching["runs"] as? String ?? "0"
//
//                let er = statspitching["earnedRuns"] as? String ?? "0"
//                let k = statspitching["strikeOuts"] as? String ?? "0"
//                let hr = statspitching["homeRuns"] as? String ?? "0"
//                let bb = statspitching["baseOnBalls"] as? String ?? "0"
//                
//                
//                let pitcherBox = PitcherBox(name: name, number: id, ip: ip, h: h, r: r, er: er, bb: bb, k: k, hr: hr, era: era)
//                pitcherInfomations.append(pitcherBox)
//                
//                
//            }
////            print(awayplayers)
//            
//            let homeList = teams["home"] as? [String: Any] ?? [:]
//            let homebatters = homeList["batters"] as? [Int] ?? []
//            let homepitchers = homeList["pitchers"] as? [Int] ?? []
//            let homeplayers = homeList["players"] as? [String: Any] ?? [:]
//            
//            var homebattersInfomations: [BatterBox] = []
//            for homebatter in homebatters {
//                let player = homeplayers["ID\(homebatter)"] as? [String: Any] ?? [:]
//                
//                let person = player["person"] as? [String: Any] ?? [:]
//                let name = person["fullName"] as? String ?? ""
//                let id = person["id"] as? String ?? ""
//                
//                let seasonStats = player["seasonStats"] as? [String: Any] ?? [:]
//                let batting = seasonStats["batting"] as? [String: Any] ?? [:]
//                let avg = batting["avg"] as? String ?? ".000"
//                let ops = batting["ops"] as? String ?? ".000"
//                
//                let stats = player["stats"] as? [String: Any] ?? [:]
//                let statsbatting = stats["batting"] as? [String: Any] ?? [:]
//                let ab = String( statsbatting["atBats"] as? Int ?? 0 )
//                let r = String( statsbatting["runs"] as? Int ?? 0 )
//                let h = String( statsbatting["hits"] as? Int ?? 0 )
//                let rbi = String( statsbatting["rbi"] as? Int ?? 0 )
//                let bb = String( statsbatting["baseOnBalls"] as? Int ?? 0 )
//                let k = String( statsbatting["strikeOuts"] as? Int ?? 0 )
//                let lob = String( statsbatting["leftOnBase"] as? Int ?? 0 )
//                
//                let battingOrder = player["battingOrder"] as? String ?? "0"
//                
//                let batterBox = BatterBox(name: name, number: id, battingOrder: Int(battingOrder) ?? 0, ab: ab, r: r, h: h, rbi: rbi, bb: bb, k: k, lob: lob, avg: avg, ops: ops)
//                homebattersInfomations.append(batterBox)
//            }
//            var homepitcherInfomations: [PitcherBox] = []
//            for homepitcher in homepitchers {
//                let player = homeplayers["ID\(homepitcher)"] as? [String: Any] ?? [:]
//                
//                let person = player["person"] as? [String: Any] ?? [:]
//                let name = person["fullName"] as? String ?? ""
//                let id = person["id"] as? String ?? ""
//                
//                let seasonStats = player["seasonStats"] as? [String: Any] ?? [:]
//                let pitching = seasonStats["pitching"] as? [String: Any] ?? [:]
//                let era = pitching["era"] as? String ?? "-.--"
//                
//                let stats = player["stats"] as? [String: Any] ?? [:]
//                let statspitching = stats["pitching"] as? [String: Any] ?? [:]
//                let ip = statspitching["inningsPitched"] as? String ?? "0.0"
//                let h = statspitching["hits"] as? String ?? "0"
//                let r = statspitching["runs"] as? String ?? "0"
//
//                let er = statspitching["earnedRuns"] as? String ?? "0"
//                let k = statspitching["strikeOuts"] as? String ?? "0"
//                let hr = statspitching["homeRuns"] as? String ?? "0"
//                let bb = statspitching["baseOnBalls"] as? String ?? "0"
//                
//                
//                let pitcherBox = PitcherBox(name: name, number: id, ip: ip, h: h, r: r, er: er, bb: bb, k: k, hr: hr, era: era)
//                homepitcherInfomations.append(pitcherBox)
//                
//            }
//            
//            let boxscoreinfo = BoxScore(awayBatters: battersInfomations, homeBatters: homebattersInfomations, awayPitchers: pitcherInfomations, homePitchers: homepitcherInfomations)
//            
//            let innings = linescore["innings"] as? [[String: Any]] ?? []
//            let currentInning = linescore["currentInning"] as? Int ?? 0
//            
//            let offense = linescore["offense"] as? [String: Any] ?? [:]
//            let first = offense["first"] as? [String: Any] ?? [:]
//            let firstName = first["fullName"] as? String
//            let firstNameid = first["id"] as? Int ?? 0
//            let firstPlayer = Player(name: firstName, number: "\(firstNameid)")
//            
//            let second = offense["second"] as? [String: Any] ?? [:]
//            let secondName = second["fullName"] as? String
//            let secondNameid = second["id"] as? Int ?? 0
//            let secondPlayer = Player(name: secondName, number: "\(secondNameid)")
//            
//            let third = offense["third"] as? [String: Any] ?? [:]
//            let thirdName = third["fullName"] as? String
//            let thirdNameid = third["id"] as? Int ?? 0
//            let thirdPlayer = Player(name: thirdName, number: "\(thirdNameid)")
//            
//            let batter = offense["batter"] as? [String: Any] ?? [:]
//            let batterName = batter["fullName"] as? String
//            let batterNameid = batter["id"] as? Int ?? 0
//            let batterPlayer = Player(name: batterName, number: "\(batterNameid)")
//            
//            let strikes = linescore["strikes"] as? Int
//            let outs = linescore["outs"] as? Int
//            let balls = linescore["balls"] as? Int
//            
//            let outCount = OutCount(balls: balls ?? 0, strikes: strikes ?? 0, outs: outs ?? 0)
//            let runner = Runner(batter: batterPlayer, first: firstPlayer, second: secondPlayer, third: thirdPlayer)
//            let normalInnings = 9
//            
//            
//            var newInnings: [Inning] = []
//            
//            for inning in innings {
//                let number = inning["num"] as? Int ?? 0
//                let away = inning["away"] as? [String: Any] ?? [:]
//                let home = inning["home"] as? [String: Any] ?? [:]
//                
//                let awayScore = away["runs"] as? Int ?? 0
//                let homeScore = home["runs"] as? Int ?? 0
//                
//                newInnings.append(Inning(inningNumber: number, away: awayScore, home: homeScore))
//            }
//            
//            let teamsResult = linescore["teams"] as? [String: Any] ?? [:]
//            let away = teamsResult["away"] as? [String: Any] ?? [:]
//            let home = teamsResult["home"] as? [String: Any] ?? [:]
//            let awayScore = away["runs"] as? Int ?? 0
//            let homeScore = home["runs"] as? Int ?? 0
//            
//            let currentInningOrdinal = linescore["currentInningOrdinal"] as? String ?? ""
//            let linescoreinningState = linescore["inningState"] as? String ?? ""
//            let inningState = InningState(rawValue: linescoreinningState) ?? .end
//            let inningLive = InningLive(innings: newInnings, awayScore: String(awayScore), homeScore: String(homeScore), currentInning: currentInningOrdinal, state: inningState)
//            
//            return LiveScore(outCount: outCount, innings: newInnings, runner: runner, boxScore: boxscoreinfo, inningLive: inningLive)
//            
//        } catch {
//            print(error)
//            return nil
//        }
//        
//    }
//    
//    static func schedule(startDate: Date) async -> [Schedule] {
//        let start = DateInRegion(startDate, region: .UTC).toFormat("MM/dd/yyyy")
//        
//        let end = DateInRegion(.now, region: .UTC).dateByAdding(2, .day).dateAtStartOf(.day).toFormat("MM/dd/yyyy")
//        print(start)
//        print(end)
//        do {
//            let endPoint = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(start)&endDate=\(end)&sportId=1&hydrate=team(league),venue(location,timezone),linescore(matchup,runners,positions),decisions,homeRuns,probablePitcher,flags,review,seriesStatus,person,stats,broadcasts(all)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let url = URL(string: endPoint)!
//            let response = try await URLSession.shared.data(from: url)
//            let data = response.0
//            
//            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
//            let dic = json?["dates"] as? [Any] ?? []
//            
//            var schedules: [Schedule] = []
//            
//            for date in dic {
//                
//                var gameDates: [GameDate] = []
//                let dicDate = date as? [String: Any] ?? [:]
//                let date = dicDate["date"] as? String ?? ""
//                
//                let games = dicDate["games"] as? [[String: Any]] ?? []
//                var gs: [Game] = []
//                let firstGame = games.first?["gameDate"] as? String ?? ""
//                
//                let timezone: Zones = Zones.asiaSeoul
//                let calendar: Calendars = Calendars.gregorian
//                let locale: Locales = Locales.korean
//                
//                
//                let kst = firstGame.toISODate(region: .current)?.toFormat("yyyy-MM-dd Z") ?? ""
//                
//                for game in games {
//                    let gamed = game["gameDate"] as? String
//                    let gamePk = game["gamePk"] as? Int ?? 0
//                    
//                    let decisions = game["decisions"] as? [String: Any] ?? [:]
//                    
//                    
//                    let loser = decisions["loser"] as? [String: Any] ?? [:]
//                    let loserlastName = loser["lastName"] as? String ?? ""
//                    
//                    let save = decisions["save"] as? [String: Any] ?? [:]
//                    let savelastName = save["lastName"] as? String ?? ""
//                    
//                    let winner = decisions["winner"] as? [String: Any] ?? [:]
//                    let winnerlastName = winner["lastName"] as? String ?? ""
//                    
//                    
//                    
//                    
//                    let teams = game["teams"] as? [String: Any] ?? [:]
//                    //                        print("Teams: \(teams)")
//                    let status = game["status"] as? [String: Any] ?? [:]
//                    let abstractGameState = status["abstractGameState"] as? String ?? ""
//                    
//                    let reason = status["reason"] as? String
//                    
//                    let homeTeamInfo = teams["home"] as? [String: Any] ?? [:]
//                    let homeTeam = homeTeamInfo["team"] as? [String: Any] ?? [:]
//                    let homeTeamName = homeTeam["teamName"] as? String ?? ""
//                    let homeTeamNamefirst = homeTeam["franchiseName"] as? String ?? ""
//                    let homeAbbreviation = (homeTeam["abbreviation"] as? String ?? "").lowercased().replacingOccurrences(of: "az", with: "ari")
//                    let awayTeamInfo = teams["away"] as? [String: Any] ?? [:]
//                    
//                    let awayTeam = awayTeamInfo["team"] as? [String: Any] ?? [:]
//                    let awayTeamName = awayTeam["teamName"] as? String ?? ""
//                    let awayTeamNameFirst = awayTeam["franchiseName"] as? String ?? ""
//                    let awayAbbreviation = (awayTeam["abbreviation"] as? String ?? "").lowercased().replacingOccurrences(of: "az", with: "ari")
//                    //                        print(teams)
//                    
//                    let linescore = game["linescore"] as? [String: Any] ?? [:]
//                    let isTopInning = linescore["isTopInning"] as? Bool ?? false
//                    let currentInning = linescore["currentInning"] as? Int ?? 0
//                    let teamsResult = linescore["teams"] as? [String: Any] ?? [:]
//                    let away = teamsResult["away"] as? [String: Any] ?? [:]
//                    let home = teamsResult["home"] as? [String: Any] ?? [:]
//                    let awayScore = away["runs"] as? Int ?? 0
//                    let homeScore = home["runs"] as? Int ?? 0
//                    
//                    
//                    var awayWinner: String? = nil
//                    var awaySave: String? = nil
//                    var awayloser: String? = nil
//                    
//                    var homeWinner: String? = nil
//                    var homeSave: String? = nil
//                    var homeloser: String? = nil
//
//                    
//                    if awayScore > homeScore {
//                        awayWinner = winnerlastName
//                        awaySave = savelastName
//                        awayloser = nil
//                        
//                        homeWinner = nil
//                        homeSave = nil
//                        homeloser = loserlastName
//                    } else {
//                        awayWinner = nil
//                        awaySave = nil
//                        awayloser = loserlastName
//                        
//                        homeWinner = winnerlastName
//                        homeSave = savelastName
//                        homeloser = nil
//                    }
//                    let homeObject = Team(score: homeScore, locationName: homeTeamNamefirst, clubName: homeTeamName, symbol: homeAbbreviation, winner: homeWinner, save: homeSave, loser: homeloser)
//                    let awayObject = Team(score: awayScore, locationName: awayTeamNameFirst, clubName: awayTeamName, symbol: awayAbbreviation, winner: awayWinner, save: awaySave, loser: awayloser)
//                    
//                    let game = Game(
//                        currentInning: currentInning,
//                        isTopInning: isTopInning,
//                        away: awayObject,
//                        home: homeObject,
//                        state: abstractGameState,
//                        reason: reason,
//                        date: gamed?.toISODate(region: .UTC)?.date,
//                        gameId: gamePk
//                    )
//                    gs.append(game)
//                    
//                }
//                
//                gameDates.append(GameDate(date: kst, games: gs))
//                schedules.append(Schedule(dates: gameDates))
//            }
//            
//            return schedules
//            
//        } catch {
//            print(error)
//            return []
//        }
//        
//    }
//}
