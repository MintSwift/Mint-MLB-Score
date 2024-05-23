import Foundation
import MLBStatsAPI

public protocol ScheduleDataSourceProtocol {
    func all() async -> MLBScheduleDTO?
    func team(id: Int) async -> MLBScheduleDTO?
}

public class ScheduleDataSource: ScheduleDataSourceProtocol {
    let provier: Providable
    
    public init(provier: Providable) {
        self.provier = provier
    }
    
    public func all() async -> MLBScheduleDTO? {
        await provier.fetch(.allSchedule, type: MLBScheduleDTO.self)
    }
    
    public func team(id: Int) async -> MLBScheduleDTO? {
        await provier.fetch(.teamSchedule(teamId: id), type: MLBScheduleDTO.self)
    }
}
