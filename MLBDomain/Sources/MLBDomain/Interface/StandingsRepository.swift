import Foundation

public protocol StandingsRepository {
    func league() async -> MLBStandings?
}
