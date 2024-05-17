import Foundation
import SwiftDate

struct SeasonRecord: Identifiable, Hashable, Equatable {
    var id: String

        let avg: String
        let ops: String
    
    init(avg: String,
         ops: String) {
        self.id = UUID().uuidString
        self.avg = avg
        self.ops = ops
    }
}

struct PitcherSeasonRecord: Identifiable, Hashable, Equatable {
    var id: String
    let era: String
    
    init(era: String) {
        self.id = UUID().uuidString
        self.era = era
    }
}

struct PitcherTodayRecord: Identifiable, Hashable, Equatable {
    var id: String

    let ip: String
    let h: String
    let r: String
    let er: String
    let bb: String
    let k: String
    let hr: String
    
    init(ip: String, h: String, r: String, er: String, bb: String, k: String, hr: String) {
        self.id = UUID().uuidString
        self.ip = ip
        self.h = h
        self.r = r
        self.er = er
        self.bb = bb
        self.k = k
        self.hr = hr
    }
}

struct TodayRecord: Identifiable, Hashable, Equatable {
    var id: String

    let ab: String
    let r: String
    let h: String

    let rbi: String
    let bb: String
    let k: String
    let lob: String
    
    init(ab: String,
         r: String,
         h: String,
         rbi: String,
         bb: String,
         k: String,
         lob: String) {
        self.id = UUID().uuidString
        self.ab = ab
        self.r = r
        self.h = h
        self.rbi = rbi
        self.bb = bb
        self.k = k
        self.lob = lob
    }
}

struct Player: Identifiable, Hashable, Equatable {
    var id: String
    
    let name: String?
    let number: String?
    
    let seasonRecord: SeasonRecord?
    let todayRecord: TodayRecord?
    
    init(name: String?, number: String?, todayRecord: TodayRecord? = nil, seasonRecord: SeasonRecord? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.number = number
        self.todayRecord = todayRecord
        self.seasonRecord = seasonRecord
    }

}

struct MPlayer: Identifiable, Hashable, Equatable, Decodable {
    var id: String
    
    let name: String?
    let number: String?
    
    let battingOrder: Int
    
    let seasonRecord: SeasonRecord?
    let todayRecord: TodayRecord?
    
    let pitcherSeasonRecord: PitcherSeasonRecord?
    let pitcherTodayRecord: PitcherTodayRecord?
    
    enum CodingKeys: CodingKey {
        case person
        case stats
        case seasonStats
        case battingOrder
    }
    
    enum PersonCodingKeys: CodingKey {
        case id
        case fullName
    }
    
    enum StatsCodingKeys: CodingKey {
        case batting
        case pitching
    }
    
    enum BattingCodingKeys: CodingKey {
        case atBats
        case runs
        case hits
        case rbi
        case baseOnBalls
        case strikeOuts
        case leftOnBase
        
        case avg
        case ops
    }
    
    enum PitchingCodingKeys: CodingKey {
        case inningsPitched
        case hits
        case runs
        case earnedRuns
        case baseOnBalls
        case strikeOuts
        case homeRuns
        
        case era
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let personContainer = try container.nestedContainer(keyedBy: PersonCodingKeys.self, forKey: .person)
        self.id = UUID().uuidString
        self.name = try personContainer.decodeIfPresent(String.self, forKey: .fullName)
        let number = try personContainer.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.number = String( number )
        
        let order = try container.decodeIfPresent(String.self, forKey: .battingOrder)
        self.battingOrder = Int(order ?? "000") ?? 0
        
        let stateContainer = try container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .stats)
        let battingContainer = try stateContainer.nestedContainer(keyedBy: BattingCodingKeys.self, forKey: .batting)
        
        let ab = try battingContainer.decodeIfPresent(Int.self, forKey: .atBats) ?? 0
        let r = try battingContainer.decodeIfPresent(Int.self, forKey: .runs) ?? 0
        let h = try battingContainer.decodeIfPresent(Int.self, forKey: .hits) ?? 0
        let rbi = try battingContainer.decodeIfPresent(Int.self, forKey: .rbi) ?? 0
        let bb = try battingContainer.decodeIfPresent(Int.self, forKey: .baseOnBalls) ?? 0
        let k = try battingContainer.decodeIfPresent(Int.self, forKey: .strikeOuts) ?? 0
        let lob = try battingContainer.decodeIfPresent(Int.self, forKey: .leftOnBase) ?? 0
        
        self.todayRecord = TodayRecord(ab: String(ab), r: String(r), h: String(h), rbi: String(rbi), bb: String(bb), k: String(k), lob: String(lob))
        
        let seasonStatsContainer = try container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .seasonStats)
        
        let seasonBattingContainer = try seasonStatsContainer.nestedContainer(keyedBy: BattingCodingKeys.self, forKey: .batting)
        let avg = try seasonBattingContainer.decodeIfPresent(String.self, forKey: .avg) ?? ".000"
        let ops = try seasonBattingContainer.decodeIfPresent(String.self, forKey: .ops) ?? ".000"
        
        self.seasonRecord = SeasonRecord(avg: avg, ops: ops)
        
        let pitchingContainer = try stateContainer.nestedContainer(keyedBy: PitchingCodingKeys.self, forKey: .pitching)
        let p_ip = try pitchingContainer.decodeIfPresent(String.self, forKey: .inningsPitched) ?? "0.0"
        let p_h = try pitchingContainer.decodeIfPresent(Int.self, forKey: .hits) ?? 0
        let p_r = try pitchingContainer.decodeIfPresent(Int.self, forKey: .runs) ?? 0
        let p_er = try pitchingContainer.decodeIfPresent(Int.self, forKey: .earnedRuns) ?? 0
        let p_bb = try pitchingContainer.decodeIfPresent(Int.self, forKey: .baseOnBalls) ?? 0
        let p_k = try pitchingContainer.decodeIfPresent(Int.self, forKey: .strikeOuts) ?? 0
        let p_hr = try pitchingContainer.decodeIfPresent(Int.self, forKey: .homeRuns) ?? 0
        self.pitcherTodayRecord = PitcherTodayRecord(ip: String(p_ip), h: String(p_h), r: String(p_r), er: String(p_er), bb: String(p_bb), k: String(p_k), hr: String(p_hr))
        
        
        let seasonPitchingContainer = try seasonStatsContainer.nestedContainer(keyedBy: PitchingCodingKeys.self, forKey: .pitching)
        let era = try seasonPitchingContainer.decodeIfPresent(String.self, forKey: .era) ?? ".000"

        
        self.pitcherSeasonRecord = PitcherSeasonRecord(era: era)
    }
    
}

struct Runner: Identifiable, Hashable, Equatable {
    var id: String
    
    let batter: Player
    let first: Player
    let second: Player
    let third: Player
    
    init(batter: Player, first: Player, second: Player, third: Player) {
        self.id = UUID().uuidString
        self.batter = batter
        self.first = first
        self.second = second
        self.third = third
    }
    
    static var review: Runner {
        let batter = Player(name: "Adley Rutschman", number: "668939")
        let first = Player(name: "Corbin Burnes", number: "669203")
        let second = Player(name: "Keegan Akin", number: "669211")
        let third = Player(name: "Jordan Westburg", number: "672335")
        
        
        let r = Runner(batter: batter, first: first, second: second, third: third)
        return r
    }
}

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
    
    let abstractGameState: StatusState
    let detailedState: StatusState?
    
    enum TeamsCodingKeys: CodingKey {
        case away
        case home
    }
    
    enum StatusCodingKeys: CodingKey {
        case abstractGameState
        case detailedState
    }
    
    enum GameCodingKeys: CodingKey {
        case pk
    }
    
    
    enum CodingKeys: CodingKey {
        case teams
        case game
        case status
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let teamsContainer = try container.nestedContainer(keyedBy: TeamsCodingKeys.self, forKey: .teams)
        
        self.away = try teamsContainer.decode(LiveTeamRespone.self, forKey: .away)
        self.home = try teamsContainer.decode(LiveTeamRespone.self, forKey: .home)
        
        let game = try container.nestedContainer(keyedBy: GameCodingKeys.self, forKey: .game)
        
        self.pk = try game.decode(Int.self, forKey: .pk)
        
        let statusContainer = try container.nestedContainer(keyedBy: StatusCodingKeys.self, forKey: .status)
        let abstractGameState = try statusContainer.decode(StatusState.self, forKey: .abstractGameState)
        let detailedState = try? statusContainer.decodeIfPresent(StatusState.self, forKey: .detailedState)
        self.abstractGameState = abstractGameState
        self.detailedState = detailedState
    }
}

struct TeamPlayersResponse: Decodable {
    let batters: [MPlayer]
    let players: [String: MPlayer]
    let pitchers: [MPlayer]
    
    enum CodingKeys: CodingKey {
        case batters
        case players
        case pitchers
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let batters = try container.decode([Int].self, forKey: .batters)
        let pitchers = try container.decode([Int].self, forKey: .pitchers)
        
        self.players = try container.decode([String: MPlayer].self, forKey: .players)
        
        var ts: [MPlayer] = []
        for batter in batters {
            let id = "ID\(batter)"
            if let e = self.players[id] {
                ts.append(e)
            }
        }
        self.batters = ts
        
        var ps: [MPlayer] = []
        for pitcher in pitchers {
            let id = "ID\(pitcher)"
            if let e = self.players[id] {
                ps.append(e)
            }
        }
        
        self.pitchers = ps
    }
}


struct BoxScoreResponse: Decodable {
    let away: TeamPlayersResponse
    let home: TeamPlayersResponse
    
    enum CodingKeys: CodingKey {
        case teams
    }
    
    enum TeamsCodingKeys: CodingKey {
        case away
        case home
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let teamsContainer = try container.nestedContainer(keyedBy: TeamsCodingKeys.self, forKey: .teams)
        
        self.away = try teamsContainer.decode(TeamPlayersResponse.self, forKey: .away)
        self.home = try teamsContainer.decode(TeamPlayersResponse.self, forKey: .home)
    }
}

struct LiveDataResponse: Decodable {
    let lineScore: LineScoreResponse
    let boxScore: BoxScoreResponse
    
    enum CodingKeys: CodingKey {
        case linescore
        case boxscore
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.lineScore = try container.decode(LineScoreResponse.self, forKey: .linescore)
        self.boxScore = try container.decode(BoxScoreResponse.self, forKey: .boxscore)
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
        let endPoint = "https://statsapi.mlb.com/api/v1.1/game/\(id)/feed/live".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        do {
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
            print(endPoint)
            print(error)
            return nil
        }
        
    }
}
