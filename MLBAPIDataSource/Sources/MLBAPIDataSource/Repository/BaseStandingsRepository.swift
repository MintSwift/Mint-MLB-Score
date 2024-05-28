import Foundation
import MLBDomain

public class BaseStandingsRepository {
    let dataSource: StandingsDataSource
    
    public init(dataSource: StandingsDataSource) {
        self.dataSource = dataSource
    }
}

extension BaseStandingsRepository: StandingsRepository {
    public func league() async -> MLBDomain.MLBStandings? {
        let response = await dataSource.league()
        return response?.toDomain()
    }
}
