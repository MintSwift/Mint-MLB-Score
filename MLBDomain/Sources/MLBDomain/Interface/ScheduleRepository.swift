import Foundation

public protocol ScheduleRepository {
    func all() async -> [Schedule]
    func team(_ id: Int) async -> [Schedule]
}
