import Foundation

struct LiveScore: Identifiable, Hashable, Equatable {
    var id: String
    
    let outCount: OutCount
    let innings: [Inning]
    let runner: Runner
    let boxScore: BoxScore
    
    init(outCount: OutCount, innings: [Inning], runner: Runner, boxScore: BoxScore) {
        self.id = UUID().uuidString
        self.outCount = outCount
        self.innings = innings
        self.runner = runner
        self.boxScore = boxScore
    }
}

struct BoxScore: Identifiable, Hashable, Equatable {
    var id: String
    
    let awayBatters: [BatterBox]
    let homeBatters: [BatterBox]
    
    let awayPitchers: [PitcherBox]
    let homePitchers: [PitcherBox]
    
    init(awayBatters: [BatterBox], homeBatters: [BatterBox], awayPitchers: [PitcherBox], homePitchers: [PitcherBox]) {
        self.id = UUID().uuidString
        self.awayBatters = awayBatters
        self.homeBatters = homeBatters
        self.awayPitchers = awayPitchers
        self.homePitchers = homePitchers
    }
    
}
struct PitcherBox: Identifiable, Hashable, Equatable {
    var id: String
    
    let name: String
    let number: String

    let ip: String
    let h: String
    let r: String
    
    let er: String
    let bb: String
    let k: String
    let hr: String
    let era: String
    
    init(name: String, number: String, ip: String, h: String, r: String, er: String, bb: String, k: String, hr: String, era: String) {
        self.id = UUID().uuidString
        self.name = name
        self.number = number
        self.ip = ip
        self.h = h
        self.r = r
        self.er = er
        self.bb = bb
        self.k = k
        self.hr = hr
        self.era = era
    }
}


struct BatterBox: Identifiable, Hashable, Equatable {
    var id: String
    
    let battingOrder: Int
    
    let name: String
    let number: String

    let ab: String
    let r: String
    let h: String
    
    let rbi: String
    let bb: String
    let k: String
    let lob: String
    let avg: String
    let ops: String
    init(name: String, number: String, battingOrder: Int, ab: String, r: String, h: String, rbi: String, bb: String, k: String, lob: String, avg: String, ops: String) {
        self.id = UUID().uuidString
        self.name = name
        self.battingOrder = battingOrder
        self.number = number
        self.ab = ab
        self.r = r
        self.h = h
        self.rbi = rbi
        self.bb = bb
        self.k = k
        self.lob = lob
        self.avg = avg
        self.ops = ops
    }
}


struct Player: Identifiable, Hashable, Equatable {
    var id: String
    
    let name: String?
    let number: String?
    
    init(name: String?, number: String?) {
        self.id = UUID().uuidString
        self.name = name
        self.number = number
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
