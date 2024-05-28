import Foundation

import MLBDomain
import MLBAPIDataSource
import MLBStatsAPI
import MLBPresenter

@MainActor
class PostSeasonInteractor: ObservableObject {
    static func create() -> PostSeasonInteractor {
        let provier = MLBProvider()
//        let provier = MLBStandingMockProvider()
        
        let dataSource = BaseStandingsDataSource(provier: provier)
        let repository = BaseStandingsRepository(dataSource: dataSource)
        let usecase = BaseStandingsUseCase(repository: repository)
        return PostSeasonInteractor(usecase: usecase)
    }
    
    @Published var american: LeaguePresenter? = nil
    @Published var national: LeaguePresenter? = nil

    @Published var americanDivisionLeaders: [TeamRecordPresenter] = []
    @Published var nationalDivisionLeaders: [TeamRecordPresenter] = []
    
    @Published var americanWildCardLeaders: [TeamRecordPresenter] = []
    @Published var nationalWildCardLeaders: [TeamRecordPresenter] = []
    
    let usecase: StandingsUseCase
    
    init(usecase: StandingsUseCase) {
        self.usecase = usecase
    }

    func retrieve() async {
        if let standings = await usecase.league() {
            let presenters = StandingsPresenter.create(standings)
            self.american = presenters.american
            self.national = presenters.national

            self.americanDivisionLeaders = presenters.american.divisionLeaders
            self.americanWildCardLeaders = presenters.american.wildCardRankTop
            
            self.nationalDivisionLeaders = presenters.national.divisionLeaders
            self.nationalWildCardLeaders = presenters.national.wildCardRankTop
            
        }
    }
}
