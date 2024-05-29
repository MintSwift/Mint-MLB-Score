import Foundation

public protocol ScheduleUseCase {
    func all() async -> [Schedule]
    func live(pk: Int) async -> Live?
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
    
    public func live(pk: Int) async -> Live? {
        let object = await repository.live(pk)
        return object
    }
}
