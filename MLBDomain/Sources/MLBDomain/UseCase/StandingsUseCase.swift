import Foundation

public protocol StandingsUseCase {
    func league() async -> MLBStandings?
}

public class BaseStandingsUseCase: StandingsUseCase {
    let repository: StandingsRepository
    
    public init(repository: StandingsRepository) {
        self.repository = repository
    }
    
    public func league() async -> MLBStandings? {
        await repository.league()
    }
}
