import Foundation
struct TeamInfomation {
    let code: Int
    let name: String
    let location: String
    
    let division: Division
    let league: League
}

struct MLBClub {
    static let orioles = TeamInfomation(code: 110, name: "Orioles", location: "Baltimore", division: .east, league: .american)
}

enum MLBTeam: Int {
    case orioles = 110
    case redsox = 111
    case yankees = 147
    case bayrays = 139
    case bluejays = 141
    
    case whitesox = 145
    case guardians = 114
    case tigers = 116
    case royals = 118
    case twins = 142
    
    case astros = 117
    case angels = 108
    case athletics = 133
    case mariners = 136
    case rangers = 140
    
    
    case braves = 144
    case marlins = 146
    case mets = 121
    case phillies = 143
    case nationals = 120
    
    case cubs = 112
    case reds = 113
    case brewers = 158
    case pirates = 134
    case cardinals = 138
    
    case diamondbacks = 109
    case dodgers = 119
    case rockies = 115
    case padres = 135
    case giants = 137
}

enum Division: String {
    case east
    case central
    case west
    
    func name() -> String {
        self.rawValue.capitalized
    }
}

enum League: String {
    case american
    case national
    
    func name() -> String {
        self.rawValue.capitalized
    }
    
    func short() -> String {
        switch self {
        case .american:
            return "AL"
        case .national:
            return "NL"
        }
    }
}
