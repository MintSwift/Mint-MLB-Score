import Foundation
import MLBStatsAPI

public protocol ScheduleDataSource {
    func all() async -> MLBScheduleDTO?
    func team(_ id: Int) async -> MLBScheduleDTO?
}

public class BaseScheduleDataSource: ScheduleDataSource {
    let provier: Provider
    
    public init(provier: Provider) {
        self.provier = provier
    }
    
    public func all() async -> MLBScheduleDTO? {
        await provier.fetch(.allSchedule, type: MLBScheduleDTO.self)
    }
    
    public func team(_ id: Int) async -> MLBScheduleDTO? {
        await provier.fetch(.teamSchedule(teamId: id), type: MLBScheduleDTO.self)
    }
}
