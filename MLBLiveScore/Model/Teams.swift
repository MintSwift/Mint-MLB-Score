import Foundation
struct TeamInfomation {
    let code: Int
    let name: String
    let location: String
    let abbreviation: String
    let division: Division
    let league: League
}

struct MLBTeam {
    static var all: [TeamInfomation] = [
        MLBTeam.orioles,
        MLBTeam.redsox,
        MLBTeam.yankees,
        MLBTeam.bayrays,
        MLBTeam.bluejays,
        MLBTeam.whitesox,
        MLBTeam.guardians,
        MLBTeam.tigers,
        MLBTeam.royals,
        MLBTeam.twins,
        MLBTeam.astros,
        MLBTeam.angels,
        MLBTeam.athletics,
        MLBTeam.mariners,
        MLBTeam.rangers,
        MLBTeam.braves,
        MLBTeam.marlins,
        MLBTeam.mets,
        MLBTeam.phillies,
        MLBTeam.nationals,
        MLBTeam.cubs,
        MLBTeam.reds,
        MLBTeam.brewers,
        MLBTeam.pirates,
        MLBTeam.cardinals,
        MLBTeam.diamondbacks,
        MLBTeam.dodgers,
        MLBTeam.rockies,
        MLBTeam.padres,
        MLBTeam.giants
    ]
    
    static let orioles = TeamInfomation(code: 110, name: "Orioles", location: "Baltimore", abbreviation: "BAL", division: .east, league: .american)
    static let redsox = TeamInfomation(code: 111, name: "Red Sox", location: "Boston", abbreviation: "BOS", division: .east, league: .american)
    static let yankees = TeamInfomation(code: 147, name: "Yankees", location: "New York", abbreviation: "NYY", division: .east, league: .american)
    static let bayrays = TeamInfomation(code: 139, name: "Bay Rays", location: "Tampa", abbreviation: "TB", division: .east, league: .american)
    static let bluejays = TeamInfomation(code: 141, name: "Blue Jays", location: "Toronto", abbreviation: "TOR", division: .east, league: .american)
    static let whitesox = TeamInfomation(code: 145, name: "White Sox", location: "Chicago", abbreviation: "CHW", division: .central, league: .american)
    static let guardians = TeamInfomation(code: 114, name: "Guardians", location: "Cleveland", abbreviation: "CLE", division: .central, league: .american)
    static let tigers = TeamInfomation(code: 116, name: "Tigers", location: "Detroit", abbreviation: "DET", division: .central, league: .american)
    static let royals = TeamInfomation(code: 118, name: "Royals", location: "Kansas City", abbreviation: "KAN", division: .central, league: .american)
    static let twins = TeamInfomation(code: 142, name: "Twins", location: "Minnesota", abbreviation: "MIN", division: .central, league: .american)
    static let astros = TeamInfomation(code: 117, name: "Astros", location: "Houston", abbreviation: "HOU", division: .west, league: .american)
    static let angels = TeamInfomation(code: 108, name: "Angels", location: "Los Angeles", abbreviation: "LAA", division: .west, league: .american)
    static let athletics = TeamInfomation(code: 133, name: "Athletics", location: "Oakland", abbreviation: "OAK", division: .west, league: .american)
    static let mariners = TeamInfomation(code: 136, name: "Mariners", location: "Seattle", abbreviation: "SEA", division: .west, league: .american)
    static let rangers = TeamInfomation(code: 140, name: "Rangers", location: "Texas", abbreviation: "TEX", division: .west, league: .american)
    static let braves = TeamInfomation(code: 144, name: "Braves", location: "Atlanta", abbreviation: "ATL", division: .east, league: .national)
    static let marlins = TeamInfomation(code: 146, name: "Marlins", location: "Miami", abbreviation: "MIA", division: .east, league: .national)
    static let mets = TeamInfomation(code: 121, name: "Mets", location: "New York", abbreviation: "NYM", division: .east, league: .national)
    static let phillies = TeamInfomation(code: 143, name: "Phillies", location: "Philadelphia", abbreviation: "PHI", division: .east, league: .national)
    static let nationals = TeamInfomation(code: 120, name: "Nationals", location: "Washington", abbreviation: "WAS", division: .east, league: .national)
    static let cubs = TeamInfomation(code: 112, name: "Cubs", location: "Chicago", abbreviation: "CHC", division: .central, league: .national)
    static let reds = TeamInfomation(code: 113, name: "Reds", location: "Cincinnati", abbreviation: "CIN", division: .central, league: .national)
    static let brewers = TeamInfomation(code: 158, name: "Brewers", location: "Milwaukee", abbreviation: "MIL", division: .central, league: .national)
    static let pirates = TeamInfomation(code: 134, name: "Pirates", location: "Pittsburgh", abbreviation: "PIT", division: .central, league: .national)
    static let cardinals = TeamInfomation(code: 138, name: "Cardinals", location: "St. Louis", abbreviation: "STL", division: .central, league: .national)
    static let diamondbacks = TeamInfomation(code: 109, name: "Diamondbacks", location: "Arizona", abbreviation: "ARI", division: .west, league: .national)
    static let dodgers = TeamInfomation(code: 119, name: "Dodgers", location: "Los Angeles", abbreviation: "LAD", division: .west, league: .national)
    static let rockies = TeamInfomation(code: 115, name: "Rockies", location: "Colorado", abbreviation: "COL", division: .west, league: .national)
    static let padres = TeamInfomation(code: 135, name: "Padres", location: "San Diego", abbreviation: "SD", division: .west, league: .national)
    static let giants = TeamInfomation(code: 137, name: "Giants", location: "San Francisco", abbreviation: "SF", division: .west, league: .national)
}

enum Division: String {
    case east
    case central
    case west
    
    func name() -> String {
        self.rawValue.capitalized
    }
    
    func code(league: League) -> Int {
        switch league {
        case .american:
            switch self {
            case .east:
                return 201
            case .central:
                return 202
            case .west:
                return 200
            }
        case .national:
            switch self {
            case .east:
                return 204
            case .central:
                return 205
            case .west:
                return 203
            }
        }
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
    
    func code() -> Int {
        switch self {
        case .american:
            return 103
        case .national:
            return 104
        }
    }
}
