import Foundation
import MLBStatsAPI

public protocol ScheduleDataSource {
    func all() async -> MLBScheduleDTO?
    func live(_ pk: Int) async -> MLBLiveDTO?
}

public class BaseScheduleDataSource: ScheduleDataSource {
    let provier: Provider
    
    public init(provier: Provider) {
        self.provier = provier
    }
    
    public func all() async -> MLBScheduleDTO? {
        await provier.fetch(.allSchedule, type: MLBScheduleDTO.self)
    }
    
    public func live(_ pk: Int) async -> MLBLiveDTO? {
        await provier.fetch(.live(pk: "\(pk)"), type: MLBLiveDTO.self)
    }
}
