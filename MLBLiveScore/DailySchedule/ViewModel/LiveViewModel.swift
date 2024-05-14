import Foundation

struct TeamInfo: Identifiable, Hashable, Equatable {
    var id: String
    let teamId: String
    let teamName: String
    let wins: String
    let losses: String
    let winningPercentage: String
    
    init(_ response: LiveTeamRespone) {
        self.id = UUID().uuidString
        self.teamId = String( response.teamId )
        self.wins = String( response.wins )
        self.losses = String( response.losses )
        self.winningPercentage = response.winningPercentage
        self.teamName = response.teamName
    }
}

struct LiveScore: Identifiable, Hashable, Equatable {
    var id: String
    var away: TeamInfo
    var home: TeamInfo
    var pk: String
    
    let currentInning: String
    let inningState: InningState
    
    let awayScore: String
    let homeScore: String
    
    let outCount: OutCount
    
    let runner: Runner?
    let onDeckPlayer: Player?
    
    
    init(_ response: LiveScoreBoard) {
        self.id = UUID().uuidString
        self.away = TeamInfo(response.gameRespone.away)
        self.home = TeamInfo(response.gameRespone.home)
        self.pk = String( response.gameRespone.pk )
        
        self.currentInning = response.liveDataResponse.lineScore.currentInning ?? "-"
        self.inningState = response.liveDataResponse.lineScore.inningState ?? .top
        
        self.awayScore = String( response.liveDataResponse.lineScore.away.runs ?? 0 )
        self.homeScore = String( response.liveDataResponse.lineScore.home.runs ?? 0 )
        
        self.outCount = response.liveDataResponse.lineScore.outCount
        
        self.runner = response.liveDataResponse.lineScore.runner
        self.onDeckPlayer = response.liveDataResponse.lineScore.onDeckPlayer
    }
}
