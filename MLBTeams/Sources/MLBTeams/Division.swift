import Foundation

public enum Division: String {
    case east
    case central
    case west
    
    public func name() -> String {
        self.rawValue.capitalized
    }
    
    public func code(league: League) -> Int {
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
