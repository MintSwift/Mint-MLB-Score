import Foundation

public protocol ScheduleRepository {
    func all() async -> [Schedule]
    func live(_ pk: Int) async -> Live?
}
