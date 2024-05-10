import Foundation

struct LiveScore: Identifiable, Hashable, Equatable {
    var id: String
    
    let outCount: OutCount
    let innings: [Inning]
    
    init(outCount: OutCount, innings: [Inning]) {
        self.id = UUID().uuidString
        self.outCount = outCount
        self.innings = innings
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

struct Inning: Identifiable, Hashable, Equatable {
    var id: String
    
    let inningNumber: String
    let away: String
    let home: String
    
    init(inningNumber: Int, away: Int, home: Int) {
        self.id = UUID().uuidString
        self.inningNumber = "\(inningNumber)"
        self.away = "\(away)"
        self.home = "\(home)"
    }
    
    init(inningNumber: String, away: String, home: String) {
        self.id = UUID().uuidString
        self.inningNumber = inningNumber
        self.away = away
        self.home = home
    }

    
    static func empty(inningNumber: Int) -> Inning {
        Inning(inningNumber: "\(inningNumber)", away: " ", home: " ")
    }
}
