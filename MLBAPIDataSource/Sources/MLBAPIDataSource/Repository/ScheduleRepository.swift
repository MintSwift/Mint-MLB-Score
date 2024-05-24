import Foundation
import MLBDomain

public class BaseScheduleRepository {
    let dataSource: ScheduleDataSource
    
    public init(dataSource: ScheduleDataSource) {
        self.dataSource = dataSource
    }
}

extension BaseScheduleRepository: ScheduleRepository {
    public func all() async -> [MLBDomain.Schedule] {
        let response = await dataSource.all()
        return response?.dates.map { $0.toDomain() } ?? []
    }
    
    public func team(_ id: Int) async -> [MLBDomain.Schedule] {
        let response = await dataSource.team(id)
        return []
    }
}
