import Foundation
import MLBStatsAPI

public protocol StandingsDataSource {
    func league() async -> MLBStandingsDTO?
}

public class BaseStandingsDataSource: StandingsDataSource {
    let provier: Provider
    
    public init(provier: Provider) {
        self.provier = provier
    }
    
    public func league() async -> MLBStandingsDTO? {
        await provier.fetch(.leagueStandings(league: .all), type: MLBStandingsDTO.self)
    }
}
