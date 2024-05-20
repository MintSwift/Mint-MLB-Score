import Foundation

public enum League: String {
    case american
    case national
    
    public func name() -> String {
        self.rawValue.capitalized
    }
    
    public func short() -> String {
        switch self {
        case .american:
            return "AL"
        case .national:
            return "NL"
        }
    }
    
    public func code() -> Int {
        switch self {
        case .american:
            return 103
        case .national:
            return 104
        }
    }
}
