import Foundation
import MLBAPIDataSource
import MLBDomain

public protocol ScheduleUseCaseProtocol {
    func all() async -> MLBPlan?
    func team(id: Int) async
}

public class ScheduleUseCase: ScheduleUseCaseProtocol {
    let dataSource: ScheduleDataSourceProtocol
    
    public init(dataSource: ScheduleDataSourceProtocol) {
        self.dataSource = dataSource
    }
    
    public func all() async -> MLBPlan? {
        let object = await dataSource.all()
        return object?.toDomain()
    }
    
    public func team(id: Int) async {
       _ = await dataSource.team(id: 1)
    }
}
