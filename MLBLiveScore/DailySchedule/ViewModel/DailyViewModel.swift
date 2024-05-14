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
    
    init(_ response: TeamResponse) {
        self.franchiseName = response.franchiseName
        self.teamName = response.teamName
        let id = response.teamID
        self.teamID = String( id )
        self.isWinner = response.isWinner
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
    
    let state: StatusState
    let stateReason: String?
    
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
}
