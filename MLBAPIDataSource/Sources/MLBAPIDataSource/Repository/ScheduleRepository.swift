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
    
    public func live(_ pk: Int) async -> MLBDomain.Live? {
        let response = await dataSource.live(pk)
        return response?.toDomain()
    }
}
