import Foundation

public protocol ScheduleUseCase {
    func all() async -> [Schedule]
    func team(id: Int) async
}

public class BaseScheduleUseCase: ScheduleUseCase {
    let repository: ScheduleRepository
    
    public init(repository: ScheduleRepository) {
        self.repository = repository
    }
    
    public func all() async -> [Schedule] {
        let object = await repository.all()
        return object
    }
    
    public func team(id: Int) async {
       _ = await repository.team(1)
    }
}
