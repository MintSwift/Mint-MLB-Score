import Foundation
import SwiftDate

protocol TeamProtocol {
    var franchiseName: String { get }
    var teamName: String { get }
}

struct Team: Hashable, Equatable, TeamProtocol {
    let franchiseName: String
    let teamName: String
    let teamID: String
    let isWinner: Bool?
    let probablePitcher: Player
    
    init(_ response: TeamResponse) {
        self.franchiseName = response.franchiseName
        self.teamName = response.teamName
        let id = response.teamID
        self.teamID = String( id )
        self.isWinner = response.isWinner
        
        self.probablePitcher = Player(name: response.probablePitcher?.name,
                                      number: "\(response.probablePitcher?.number ?? 0)")
    }
    
    
    init(franchiseName: String,
         teamName: String,
         teamID: String,
         isWinner: Bool?,
         probablePitcher: Player) {
        self.franchiseName = franchiseName
        self.teamName = teamName
        self.teamID = teamID
        self.isWinner = isWinner
        self.probablePitcher = probablePitcher
    }
    
}
struct Innings: Identifiable, Hashable, Equatable {
    var id: String
    let num: Int
    let ordinalNum: String?
    let away: TeamScore
    let home: TeamScore
    
    init(num: Int, ordinalNum: String?, away: TeamScore, home: TeamScore) {
        self.id = UUID().uuidString
        self.num = num
        self.ordinalNum = ordinalNum
        self.away = away
        self.home = home
    }
}

struct TeamScore: Identifiable, Hashable, Equatable {
    var id: String
    
    let runs: Int?
    let hits: Int?
    let errors: Int?
    init(runs: Int?, hits: Int?, errors: Int?) {
        self.id = UUID().uuidString
        self.runs = runs
        self.hits = hits
        self.errors = errors
    }
}


struct Game: Identifiable, Hashable, Equatable {
    var id: String
    let pk: String
    let away: Team
    let home: Team
    let date: Date
    let currentInning: String
    let inningState: InningState
    
    let awayScore: String
    let homeScore: String
    
    let innings: [Innings]
    let state: StatusState
    let stateReason: String?
    
    let winnerPitcher: Player?
    let loserPitcher: Player?
    let savePitcher: Player?
    
    init(_ response: GameRespone) {
        self.id = UUID().uuidString
        self.pk = String( response.gamePk )
        self.away = Team(response.away)
        self.home = Team(response.home)
        self.currentInning = String( response.lineScore?.currentInning ?? "-")
        self.inningState = response.lineScore?.inningState ?? .top
        
        self.awayScore = String( response.lineScore?.away.runs ?? 0 )
        self.homeScore = String( response.lineScore?.home.runs ?? 0 )
        
        self.state = response.state
        self.stateReason = response.stateReason
        self.date = response.date
        
        var newIn: [Innings] = []
        for item in response.lineScore?.innings ?? [] {
            let awayScore = TeamScore(runs: item.away.runs, hits: item.away.hits, errors: item.away.errors)
            let homeScore = TeamScore(runs: item.home.runs, hits: item.home.hits, errors: item.home.errors)
            let e = Innings(num: item.num, ordinalNum: item.ordinalNum, away: awayScore, home: homeScore)
            newIn.append(e)
        }
        
        if newIn.count < 9 {
            let number = 9 - newIn.count
            for _ in 1...number {
                let lastNumber = (newIn.last?.num ?? 0) + 1
                let stringLast = String(lastNumber).ordinal()
                
                let e = Innings(num: lastNumber,
                                ordinalNum: stringLast,
                                away: TeamScore(runs: nil, hits: nil, errors: nil),
                                home: TeamScore(runs: nil, hits: nil, errors: nil))
                newIn.append(e)
            }
        }
        
        let maxCount = Array(newIn.suffix(9))
        self.innings = maxCount
        
        self.winnerPitcher = Player(name: response.winnerPitcher?.name, number: String( response.winnerPitcher?.number ?? 0))
        self.savePitcher = Player(name: response.savePitcher?.name, number: String( response.savePitcher?.number ?? 0))
        self.loserPitcher = Player(name: response.loserPitcher?.name, number: String( response.loserPitcher?.number ?? 0))
    }
}

struct DateSection: Identifiable, Hashable, Equatable {
    var id: String
    var title: String
    var games: [Game]
    
    init(_ response: DateResponse) {
        self.id = UUID().uuidString
        let games = response.games
        
        let first = games.first?.date.toFormat("yyyy-MM-dd Z", locale: Locales.current)
        self.title = first ?? "-"
        self.games = games.map { Game($0) }
    }
    
    init(_ title: String, games: [Game]) {
        self.id = UUID().uuidString
        self.title = title
        self.games = games
    }
}
