import Foundation
import SwiftDate

struct TeamScheduleProvider {
    static func fetch(teamId: Int) async -> [DateResponse] {
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
            let game = mlbSchedule.date
            return game
        } catch {
            print(endPoint)
            print(error)
            return []
        }
        
    }
}


struct TeamStandings: Decodable {
    let divisionRank: String
    let leagueRank: String
    let wins: Int
    let losses: Int
    
    let name: String
    let abbreviation: String
    let number: Int
    let divisionShortName: String
    
    enum TeamCodingKeys: CodingKey {
        case name
        case abbreviation
        case id
        case division
    }
    
    enum DivisionCodingKeys: CodingKey {
        case nameShort
    }
    
    enum CodingKeys: CodingKey {
        case divisionRank
        case leagueRank
        case wins
        case losses
        case team
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.divisionRank = try container.decode(String.self, forKey: .divisionRank)
        self.leagueRank = try container.decode(String.self, forKey: .leagueRank)
        self.wins = try container.decode(Int.self, forKey: .wins)
        self.losses = try container.decode(Int.self, forKey: .losses)
        let teamContainer = try container.nestedContainer(keyedBy: TeamCodingKeys.self, forKey: .team)
        self.name = try teamContainer.decode(String.self, forKey: .name)
        self.abbreviation = try teamContainer.decode(String.self, forKey: .abbreviation)
        self.number = try teamContainer.decode(Int.self, forKey: .id)
        
        let divisionContainer = try teamContainer.nestedContainer(keyedBy: DivisionCodingKeys.self, forKey: .division)
        self.divisionShortName = try divisionContainer.decode(String.self, forKey: .nameShort)
    }
    
}
struct Records: Decodable {
    let teamStandings: [TeamStandings]
    
    
    enum CodingKeys: CodingKey {
        case teamRecords
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.teamStandings = try container.decode([TeamStandings].self, forKey: .teamRecords)
    }
}

struct Standings: Decodable {
    let records: [Records]
    
    enum RecordsCodingKeys: CodingKey {
        case teamRecords
    }
    
    enum TeamRecordsCodingKeys: CodingKey {
        case teamRecords
    }
    
    enum CodingKeys: CodingKey {
        case records
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.records = try container.decode([Records].self, forKey: .records)
        
    }
}



struct StandingsProvider {
    static func fetch() async -> [TeamStandings] {

        let endPoint = "https://statsapi.mlb.com/api/v1/standings?leagueId=103,104&season=2024&standingsTypes=regularSeason&hydrate=team(division)&fields=records,standingsType,teamRecords,team,name,division,id,nameShort,abbreviation,divisionRank,gamesBack,wildCardRank,wildCardGamesBack,wildCardEliminationNumber,divisionGamesBack,clinched,eliminationNumber,winningPercentage,type,wins,losses,leagueRank,sportRank".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        do {
            print(endPoint)
            let url = URL(string: endPoint)!
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            
            let decoder = JSONDecoder()
            let mlbSchedule = try decoder.decode(Standings.self, from: data)
            let standings = mlbSchedule.records.flatMap { $0.teamStandings }
            
            return standings
        } catch {
            print(endPoint)
            print(error)
            return []
        }
        
    }
}
