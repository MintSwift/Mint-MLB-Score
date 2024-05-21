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


struct TeamStandings: Decodable, Hashable {
    let divisionRank: String
    let leagueRank: String
    let wildCardRank: String?
    let wins: Int
    let losses: Int
    let winningPercentage: String
    let wildCardGamesBack: String
    
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
        case winningPercentage
        case wildCardRank
        case wildCardGamesBack
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.divisionRank = try container.decode(String.self, forKey: .divisionRank)
        self.leagueRank = try container.decode(String.self, forKey: .leagueRank)
        self.wildCardRank = try container.decodeIfPresent(String.self, forKey: .wildCardRank)
        self.wins = try container.decode(Int.self, forKey: .wins)
        self.losses = try container.decode(Int.self, forKey: .losses)
        self.winningPercentage = try container.decode(String.self, forKey: .winningPercentage)
        self.wildCardGamesBack = try container.decode(String.self, forKey: .wildCardGamesBack)
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


struct PitcherSplitsStat: Decodable {
    let wins: Int
    let losses: Int
    let era: String
}

struct PitcherSplits: Decodable {
    let stat: PitcherSplitsStat
    enum CodingKeys: CodingKey {
        case stat
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stat = try container.decode(PitcherSplitsStat.self, forKey: .stat)
    }
}


struct PitcherStats: Decodable {
    let splits: [PitcherSplits]
    
    enum CodingKeys: CodingKey {
        case splits
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.splits = try container.decode([PitcherSplits].self, forKey: .splits)
    }
}


struct PitcherPeople: Decodable {
    let stats: [PitcherStats]
    
    enum CodingKeys: CodingKey {
        case stats
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.stats = try container.decode([PitcherStats].self, forKey: .stats)
    }
}

struct PitcherPerson: Decodable {
    let people: [PitcherPeople]
    
    let wins: Int
    let losses: Int
    let era: String
    
    
    enum CodingKeys: CodingKey {
        case people
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.people = try container.decode([PitcherPeople].self, forKey: .people)
        
        self.wins = self.people.first?.stats.first?.splits.first?.stat.wins ?? 0
        self.losses = self.people.first?.stats.first?.splits.first?.stat.losses ?? 0
        self.era = self.people.first?.stats.first?.splits.first?.stat.era ?? "-"
    }
}



struct PitchingProvider {
    static func fetch(id: String) async -> PitcherPerson? {

        let endPoint = "https://statsapi.mlb.com/api/v1/people/\(id)?hydrate=stats(group=[pitching],type=season,sportId=1),currentTeam".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        do {
            print(endPoint)
            let url = URL(string: endPoint)!
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            
            let decoder = JSONDecoder()
            let mlbSchedule = try decoder.decode(PitcherPerson.self, from: data)
            print(mlbSchedule)
            
            return mlbSchedule
        } catch {
            print(endPoint)
            print(error)
            return nil
        }
        
    }
}




struct StandingsProvider {
    static func fetch(leagueId: String) async -> [TeamStandings] {

        let endPoint = "https://statsapi.mlb.com/api/v1/standings?leagueId=\(leagueId)&season=2024&standingsTypes=regularSeason&hydrate=team(division)&fields=records,standingsType,teamRecords,team,name,division,id,nameShort,abbreviation,divisionRank,gamesBack,wildCardRank,wildCardGamesBack,wildCardEliminationNumber,divisionGamesBack,clinched,eliminationNumber,winningPercentage,type,wins,losses,leagueRank,sportRank".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
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
