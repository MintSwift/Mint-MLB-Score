import Foundation

public struct Game: Equatable, Hashable {
    public let gamePk: Int
    public let gameDate: String
    public let status: Status
    public let teams: Teams
    public let decisions: Decisions?
    public let linescore: LineScore?
    
    public init(gamePk: Int, gameDate: String, status: Status, teams: Teams, decisions: Decisions?, linescore: LineScore?) {
        self.gamePk = gamePk
        self.gameDate = gameDate
        self.status = status
        self.teams = teams
        self.decisions = decisions
        self.linescore = linescore
    }
}

public struct Schedule: Equatable, Hashable {
    public let games: [Game]
    public let date: String?
    
    public init(games: [Game], date: String?) {
        self.games = games
        self.date = date
    }
}


public struct MLBPlan: Equatable, Hashable {
    public let schedules: [Schedule]
    
    public init(schedules: [Schedule]) {
        self.schedules = schedules
    }
}
