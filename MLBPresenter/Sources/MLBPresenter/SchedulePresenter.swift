import Foundation
import MLBDomain
import SwiftDate

public enum GameStatus: String, Codable {
    case final = "Final"
    case live = "Live"
    case preview = "Preview"
    case warmup = "Warmup"
    case inProgress = "In Progress"
    case scheduled = "Scheduled"
    case unknown
}

public struct StatusPresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public var status: GameStatus
    public let reason: String?
    
    init(status: Status) {
        self.id = UUID().uuidString
        self.status = GameStatus(rawValue: status.detailedState) ?? .unknown
        self.reason = status.reason
    }
}



public struct TeamPresenter : Identifiable, Equatable, Hashable {
    public var id: String

    
    public init(_ team: Teams.Team) {
        id = UUID().uuidString

       
    }
}


public struct GamePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let startDate: Date
    public let status: StatusPresenter
    public let away: TeamPresenter
    
    public init(_ game: Game) {
        id = UUID().uuidString
        startDate = game.gameDate.toISODate(region: .UTC)?.date ?? .now
        status = StatusPresenter(status: game.status)
        away = TeamPresenter(game.teams.away)
    }
}


public struct SchedulePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    public let date: String
    public var games: [GamePresenter]
    
    public init(_ schedule: Schedule) {
        id = UUID().uuidString
        games = schedule.games.map { GamePresenter($0) }
        date = games.first?.startDate.toFormat("yyyy-MM-dd Z", locale: Locales.current) ?? ""
    }
    
    public static func create(plan: MLBPlan) -> [SchedulePresenter] {
        let schedules = plan.schedules
        return schedules.map { SchedulePresenter($0) }
    }
}
