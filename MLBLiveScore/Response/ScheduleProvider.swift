import Foundation
import SwiftDate

enum StatusState: String, Codable {
    case final = "Final"
    case live = "Live"
    case preview = "Preview"
    case warmup = "Warmup"
    case inProgress = "In Progress"
    case unknown
}

struct MLBPlayer: Identifiable, Hashable, Decodable {
    let id: String
    let number: Int
    let name: String
    
    enum CodingKeys: CodingKey {
        case id
        case fullName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        
        self.number = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .fullName)
    }
}

struct TeamResponse: Identifiable, Hashable, Decodable {
    var id: String
    let wins: Int
    let losses: Int
    let pct: String
    
    let symbolCode: String
    let teamName: String
    let franchiseName: String
    let teamID: Int
    let isWinner: Bool?
    let score: Int?
    
    let probablePitcher: MLBPlayer?
    
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
    
    enum ProbablePitcherCodingKeys: CodingKey {
        case fullName
        case id
    }
    
    enum TeamCodingKeys: CodingKey {
        case fileCode
        case teamName
        case franchiseName
        case id
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        
        let leagueRecordContainer = try container.nestedContainer(keyedBy: LeagueRecordCodingKeys.self, forKey: .leagueRecord)
        self.wins = try leagueRecordContainer.decode(Int.self, forKey: .wins)
        self.losses = try leagueRecordContainer.decode(Int.self, forKey: .losses)
        self.pct = try leagueRecordContainer.decode(String.self, forKey: .pct)
        
        self.score = try container.decodeIfPresent(Int.self, forKey: .score)
        
        let teamContainer = try container.nestedContainer(keyedBy: TeamCodingKeys.self, forKey: .team)
        let symbol = try teamContainer.decode(String.self, forKey: .fileCode)
        if symbol == "ana" {
            self.symbolCode = "laa"
        } else {
            self.symbolCode = symbol
        }
        
        self.teamName = try teamContainer.decode(String.self, forKey: .teamName)
        self.franchiseName = try teamContainer.decode(String.self, forKey: .franchiseName)
        
        self.isWinner = try container.decodeIfPresent(Bool.self, forKey: .isWinner)
        self.teamID = try teamContainer.decode(Int.self, forKey: .id)
        
        self.probablePitcher = try? container.decodeIfPresent(MLBPlayer.self, forKey: .probablePitcher)
    }
}

enum InningState: String, Codable {
    case top = "Top"
    case bottom = "Bottom"
    case middle = "Middle"
    case end = "End"
    
    func text() -> String {
        switch self {
        case .top:
            return "TOP"
        case .bottom:
            return "BOT"
        case .middle:
            return "MID"
        case .end:
            return "END"
        }
    }
}

struct TeamScoreResponse: Decodable {
    let runs: Int?
    let hits: Int?
    let errors: Int?
    
    enum CodingKeys: CodingKey {
        case runs
        case hits
        case errors
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.runs = try container.decodeIfPresent(Int.self, forKey: .runs)
        self.hits = try container.decodeIfPresent(Int.self, forKey: .hits)
        self.errors = try container.decodeIfPresent(Int.self, forKey: .errors)
    }
}

struct InningResponse: Decodable {
    let num: Int
    let ordinalNum: String?
    let away: TeamScoreResponse
    let home: TeamScoreResponse
    
    enum CodingKeys: CodingKey {
        case num
        case ordinalNum
        case home
        case away
    }
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.num = try container.decode(Int.self, forKey: .num)
        self.ordinalNum = try container.decodeIfPresent(String.self, forKey: .ordinalNum)
        
        self.away = try container.decode(TeamScoreResponse.self, forKey: .away)
        self.home = try container.decode(TeamScoreResponse.self, forKey: .home)
    }
}

struct OutCount: Identifiable, Hashable, Equatable {
    var id: String

    let balls: String
    let strikes: String
    let outs: String

    init(balls: Int, strikes: Int, outs: Int) {
        self.id = UUID().uuidString
        self.balls = "\(balls)"
        self.strikes = "\(strikes)"
        self.outs = "\(outs)"
    }
}

struct LineScoreResponse: Decodable {
    let currentInning: String?
    let inningState: InningState?
    let innings: [InningResponse]
    
    let away: TeamScoreResponse
    let home: TeamScoreResponse
    
    let outCount: OutCount
    
    var runner: Runner? = nil
    
    var onDeckPlayer: Player? = nil
    
    enum CodingKeys: CodingKey {
        case currentInningOrdinal
        case currentInning
        case inningState
        case innings
        case teams
        
        case balls
        case strikes
        case outs
        
        case offense
    }
    
    enum TeamsCodingKeys: CodingKey {
        case away
        case home
    }
    
    enum OffenseCodingKeys: CodingKey {
        case first
        case second
        case third
        case batter
        case onDeck
    }
    
    enum PlayerCodingKeys: CodingKey {
        case id
        case fullName
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let currentInning = try container.decodeIfPresent(String.self, forKey: .currentInningOrdinal)
        self.currentInning = String( currentInning ?? "-")
        self.inningState = try container.decodeIfPresent(InningState.self, forKey: .inningState)
        self.innings = try container.decode([InningResponse].self, forKey: .innings)
        
        let teamsContainer = try container.nestedContainer(keyedBy: TeamsCodingKeys.self, forKey: .teams)
        self.away = try teamsContainer.decode(TeamScoreResponse.self, forKey: .away)
        self.home = try teamsContainer.decode(TeamScoreResponse.self, forKey: .home)
        
        let balls = try container.decodeIfPresent(Int.self, forKey: .balls) ?? 0
        let strikes = try container.decodeIfPresent(Int.self, forKey: .strikes) ?? 0
        let outs = try container.decodeIfPresent(Int.self, forKey: .outs) ?? 0
        self.outCount = OutCount(balls: balls, strikes: strikes, outs: outs)
        
        let offenseContainer = try? container.nestedContainer(keyedBy: OffenseCodingKeys.self, forKey: .offense)
        
        let batter = try? offenseContainer?.nestedContainer(keyedBy: PlayerCodingKeys.self, forKey: .batter)
        let first = try? offenseContainer?.nestedContainer(keyedBy: PlayerCodingKeys.self, forKey: .first)
        let second = try? offenseContainer?.nestedContainer(keyedBy: PlayerCodingKeys.self, forKey: .second)
        let third = try? offenseContainer?.nestedContainer(keyedBy: PlayerCodingKeys.self, forKey: .third)
        let onDeck = try? offenseContainer?.nestedContainer(keyedBy: PlayerCodingKeys.self, forKey: .onDeck)

        
        let batterid = try batter?.decodeIfPresent(Int.self, forKey: .id)
        let batterfullName = try batter?.decodeIfPresent(String.self, forKey: .fullName)
        let batterPlayer = Player(name: batterfullName, number: batterid == nil ? nil : String( batterid ?? 0 ))
        let firstid = try first?.decodeIfPresent(Int.self, forKey: .id)
        let firstfullName = try first?.decodeIfPresent(String.self, forKey: .fullName)
        let firstPlayer = Player(name: firstfullName, number: firstid == nil ? nil : String( firstid ?? 0 ))
        let secondid = try second?.decodeIfPresent(Int.self, forKey: .id)
        let secondfullName = try second?.decodeIfPresent(String.self, forKey: .fullName)
        let secondPlayer = Player(name: secondfullName, number: secondid == nil ? nil : String( secondid ?? 0 ))
        let thirdid = try third?.decodeIfPresent(Int.self, forKey: .id)
        let thirdfullName = try third?.decodeIfPresent(String.self, forKey: .fullName)
        let thirdPlayer = Player(name: thirdfullName, number: thirdid == nil ? nil : String( thirdid ?? 0 ))
        let onDeckid = try onDeck?.decodeIfPresent(Int.self, forKey: .id)
        let onDeckfullName = try onDeck?.decodeIfPresent(String.self, forKey: .fullName)
        let onDeckPlayer = Player(name: onDeckfullName, number: onDeckid == nil ? nil : String( onDeckid ?? 0 ))
        
        self.runner = Runner(batter: batterPlayer, first: firstPlayer, second: secondPlayer, third: thirdPlayer)
        self.onDeckPlayer = onDeckPlayer
    }
    
}

struct GameRespone: Identifiable, Decodable {
    var id: String
    let gamePk: Int
    let date: Date
    
    let away: TeamResponse
    let home: TeamResponse
    
    let lineScore: LineScoreResponse?
    let state: StatusState
    let stateReason: String?
    
    let winnerPitcher: MLBPlayer?
    let loserPitcher: MLBPlayer?
    let savePitcher: MLBPlayer?
    
    enum CodingKeys: CodingKey {
        case gamePk
        case gameDate
        case status
        case teams
        case linescore
        case decisions
    }
    
    enum StatusCodingKeys: CodingKey {
        case abstractGameState
        case reason
    }

    enum TeamsCodingKeys: CodingKey {
        case away
        case home
    }

    
    enum DecisionsCodingKeys: CodingKey {
        case winner
        case loser
        case save
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.gamePk = try container.decode(Int.self, forKey: .gamePk)
        let gameDate = try container.decode(String.self, forKey: .gameDate)
        self.date = gameDate.toISODate(region: .UTC)?.date ?? .now
//        
        let statusContainer = try container.nestedContainer(keyedBy: StatusCodingKeys.self, forKey: .status)
        self.state = try statusContainer.decodeIfPresent(StatusState.self, forKey: .abstractGameState) ?? .unknown
        self.stateReason = try statusContainer.decodeIfPresent(String.self, forKey: .reason)
//        
        let teamsContainer = try container.nestedContainer(keyedBy: TeamsCodingKeys.self, forKey: .teams)
        self.away = try teamsContainer.decode(TeamResponse.self, forKey: .away)
        self.home = try teamsContainer.decode(TeamResponse.self, forKey: .home)

        
        self.lineScore = try container.decodeIfPresent(LineScoreResponse.self, forKey: .linescore)
//        let currentInning = try linescoreContainer?.decodeIfPresent(String.self, forKey: .currentInningOrdinal) ?? "-"
//        let  inningState = try linescoreContainer?.decodeIfPresent(InningState.self, forKey: .inningState) ?? .end
        
        let decisionsContainer = try? container.nestedContainer(keyedBy: DecisionsCodingKeys.self, forKey: .decisions)
        self.winnerPitcher = try decisionsContainer?.decodeIfPresent(MLBPlayer.self, forKey: .winner)
        self.loserPitcher = try decisionsContainer?.decodeIfPresent(MLBPlayer.self, forKey: .loser)
        self.savePitcher = try decisionsContainer?.decodeIfPresent(MLBPlayer.self, forKey: .save)
        
    }
}

struct DateResponse: Decodable {
    let date: Date
    
    let games: [GameRespone]
    
    enum CodingKeys: CodingKey {
        case date
        case games
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.games = try container.decode([GameRespone].self, forKey: .games)
        
        let date = try container.decode(String.self, forKey: .date)
        self.date = date.toDate(region: .UTC)?.date ?? .now
    }
}

struct MLBSchedule: Decodable {
    var id: String
    var date: [DateResponse]
    
    enum CodingKeys: CodingKey {
        case id
        case dates
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = UUID().uuidString
        self.date = try container.decode([DateResponse].self, forKey: .dates)
    }
}


struct ScheduleProvider {
    static func fetch(startDate: Date) async -> [DateResponse] {
        let start = DateInRegion(startDate, region: .UTC).toFormat("MM/dd/yyyy")
        let end = DateInRegion(.now, region: .UTC).dateByAdding(2, .day).dateAtStartOf(.day).toFormat("MM/dd/yyyy")
        let endPoint = "https://statsapi.mlb.com/api/v1/schedule?startDate=\(start)&endDate=\(end)&sportId=1&hydrate=team(league),decisions,probablePitcher,linescore".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        do {
            
            let url = URL(string: endPoint)!
            let response = try await URLSession.shared.data(from: url)
            let data = response.0
            let decoder = JSONDecoder()
            let mlbSchedule = try decoder.decode(MLBSchedule.self, from: data)
            
            return mlbSchedule.date
        } catch {
            print(endPoint)
            print(error)
            return []
        }
        
    }
}
