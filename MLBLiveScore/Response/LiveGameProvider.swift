import Foundation
import SwiftDate

struct LVTeam: Identifiable, Hashable, Decodable {
    var id: String
    let wins: Int
    let losses: Int
    let pct: String
    
    let score: Int?
    
    let symbolCode: String
    let teamName: String
    let franchiseName: String
    
    let isWinner: Bool?
    let firstPitcher: MLBPlayer?
    
    enum CodingKeys: CodingKey {
        case leagueRecord
        case record
        case team
        case score
        case isWinner
        case probablePitcher
        
        case fileCode
        case teamName
        case franchiseName
    }
    
    enum LeagueRecordCodingKeys: CodingKey {
        case wins
        case losses
        case pct
    }
    
    enum RecordCodingKeys: CodingKey {
        case leagueRecord
    }
    
    enum TeamCodingKeys: CodingKey {
        case fileCode
        case teamName
        case franchiseName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        let recordContainer = try container.nestedContainer(keyedBy: RecordCodingKeys.self, forKey: .record)
        let leagueRecordContainer = try recordContainer.nestedContainer(keyedBy: LeagueRecordCodingKeys.self, forKey: .leagueRecord)
    
        self.wins = try leagueRecordContainer.decode(Int.self, forKey: .wins)
        self.losses = try leagueRecordContainer.decode(Int.self, forKey: .losses)
        self.pct = try leagueRecordContainer.decode(String.self, forKey: .pct)
        
        self.score = try container.decodeIfPresent(Int.self, forKey: .score)
        
        let sb = try container.decode(String.self, forKey: .fileCode)
        if sb == "ana" {
            self.symbolCode = "laa"
        } else {
            self.symbolCode = sb
        }
        self.teamName = try container.decode(String.self, forKey: .teamName)
        self.franchiseName = try container.decode(String.self, forKey: .franchiseName)

        self.isWinner = try container.decodeIfPresent(Bool.self, forKey: .isWinner)
        self.firstPitcher = try container.decodeIfPresent(MLBPlayer.self, forKey: .probablePitcher)
    }
}

struct LVGameData: Identifiable, Hashable, Decodable {
    var id: String
    let state: StatusState
    let away: LVTeam
    let home: LVTeam
    
    enum CodingKeys: CodingKey {
        case status
        case teams
    }
    
    enum StatusCodingKeys: CodingKey {
        case abstractGameState
    }
    
    enum TeamCodingKeys: CodingKey {
        case away
        case home
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        
        let statusContainer = try container.nestedContainer(keyedBy: StatusCodingKeys.self, forKey: .status)
        self.state = try statusContainer.decodeIfPresent(StatusState.self, forKey: .abstractGameState) ?? .unknown
        
        let teamsContainer = try container.nestedContainer(keyedBy: TeamCodingKeys.self, forKey: .teams)
        self.away = try teamsContainer.decode(LVTeam.self, forKey: .away)
        self.home = try teamsContainer.decode(LVTeam.self, forKey: .home)
    }
    
    
}

struct LiveTeamRespone: Decodable {
    let teamId: Int
    let teamName: String
    let wins: Int
    let losses: Int
    let winningPercentage: String
    
    enum CodingKeys: CodingKey {
        case id
        case teamName
        case record
    }
    
    enum RecordCodingKeys: CodingKey {
        case wins
        case losses
        case winningPercentage
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.teamId = try container.decode(Int.self, forKey: .id)
        self.teamName = try container.decode(String.self, forKey: .teamName)
        let recordContainer = try container.nestedContainer(keyedBy: RecordCodingKeys.self, forKey: .record)
        
        self.wins = try recordContainer.decode(Int.self, forKey: .wins)
        self.losses = try recordContainer.decode(Int.self, forKey: .losses)
        self.winningPercentage = try recordContainer.decode(String.self, forKey: .winningPercentage)
        
    }
}



struct LiveGameRespone: Decodable {
    let pk: Int
    let away: LiveTeamRespone
    let home: LiveTeamRespone
    
    enum TeamsCodingKeys: CodingKey {
        case away
        case home
    }
    
    enum GameCodingKeys: CodingKey {
        case pk
    }
    
    
    enum CodingKeys: CodingKey {
        case teams
        case game
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let teamsContainer = try container.nestedContainer(keyedBy: TeamsCodingKeys.self, forKey: .teams)
        
        self.away = try teamsContainer.decode(LiveTeamRespone.self, forKey: .away)
        self.home = try teamsContainer.decode(LiveTeamRespone.self, forKey: .home)
        
        let game = try container.nestedContainer(keyedBy: GameCodingKeys.self, forKey: .game)
        
        self.pk = try game.decode(Int.self, forKey: .pk)
    }
}

struct LiveDataResponse: Decodable {
    let lineScore: LineScoreResponse

    enum CodingKeys: CodingKey {
        case linescore
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lineScore = try container.decode(LineScoreResponse.self, forKey: .linescore)
    }
}

struct LiveScoreBoard: Decodable {
    let gameRespone: LiveGameRespone
    let liveDataResponse: LiveDataResponse
    
    enum CodingKeys: CodingKey {
        case gameData
        case liveData
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.gameRespone = try container.decode(LiveGameRespone.self, forKey: .gameData)
        self.liveDataResponse = try container.decode(LiveDataResponse.self, forKey: .liveData)
    }
}

struct LiveGameProvider {
    static func fetch(id: String) async -> LiveScoreBoard? {
     
        do {
            let endPoint = "https://statsapi.mlb.com/api/v1.1/game/\(id)/feed/live".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
//            let endPoint = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(start)&endDate=\(end)&sportId=1&hydrate=team(league),decisions,probablePitcher,linescore".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            let url = URL(string: endPoint)!
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            
//            let json = try JSONSerialization.jsonObject(with: data) as? [String: Any]
//            let dic = json?["dates"] as? [Any] ?? []
//            
//            print(dic)
//            print(endPoint)
            let decoder = JSONDecoder()
            
//            return []
            let mlbSchedule = try decoder.decode(LiveScoreBoard.self, from: data)
            
            return mlbSchedule
        } catch {
            print(error)
            return nil
        }
        
    }
}
