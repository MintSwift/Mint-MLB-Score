import Foundation

struct Schedule: Identifiable, Hashable, Equatable {
    var id: String
    let dates: [GameDate]
    
    init(dates: [GameDate]) {
        self.id = UUID().uuidString
        self.dates = dates
    }
}

struct GameDate: Identifiable, Hashable, Equatable {
    var id: String
    let date: String
    let games: [Game]
    
    init(date: String, games: [Game]) {
        self.id = UUID().uuidString
        self.date = date
        self.games = games
    }
}

enum GameState: String {
    case final = "Final"
    case completedEarly = "Completed Early"
    case cameOver = "Game Over"
    case delayed = "Delayed"
    case inProgress = "In Progress"
    case live = "Live"
    case preview = "Preview"
    case pregame = "Pre-Game"
}

struct Game: Identifiable, Hashable, Equatable {
    var id: String
    let currentInning: Int
    let isTopInning: Bool
    let away: Team
    let home: Team
    let state: GameState
    let reason: String?
    let date: Date?
    let gameId: Int
    
    init(currentInning: Int, isTopInning: Bool, away: Team, home: Team, state: String, reason: String?, date: Date?, gameId: Int) {
        self.id = UUID().uuidString
        self.currentInning = currentInning
        self.isTopInning = isTopInning
        self.away = away
        self.home = home
        self.state = GameState(rawValue: state) ?? .final
        self.reason = reason
        self.date = date
        self.gameId = gameId
    }
}

struct Team: Identifiable, Hashable, Equatable {
    var id: String
    let score: Int
    let locationName: String
    let clubName: String
    let symbol: String
    
    init(score: Int, locationName: String, clubName: String, symbol: String) {
        self.id = UUID().uuidString
        self.score = score
        self.locationName = locationName
        self.clubName = clubName
        self.symbol = symbol
    }
}
