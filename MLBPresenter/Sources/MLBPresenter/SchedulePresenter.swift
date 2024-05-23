import Foundation
import MLBDomain


public struct SchedulePresenter: Identifiable, Equatable, Hashable {
    public var id: String
    
    
    public init(_ schedule: Schedule) {
        id = UUID().uuidString
    }
    
    public static func create(plan: MLBPlan) -> [SchedulePresenter] {
        let schedules = plan.schedules
        return schedules.map { SchedulePresenter($0) }
    }
}
