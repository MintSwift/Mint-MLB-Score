import Foundation

import MLBDomain
import MLBAPIDataSource
import MLBStatsAPI
import MLBPresenter

@MainActor
class WildCardRankInteractor: ObservableObject {
    static func create() -> WildCardRankInteractor {
        let provier = MLBProvider()
//        let provier = MLBStandingMockProvider()
        
        let dataSource = BaseStandingsDataSource(provier: provier)
        let repository = BaseStandingsRepository(dataSource: dataSource)
        let usecase = BaseStandingsUseCase(repository: repository)
        return WildCardRankInteractor(usecase: usecase)
    }
    
    @Published var american: LeaguePresenter? = nil
    @Published var national: LeaguePresenter? = nil

    @Published var alWildCardRank: [DivisionPresenter] = []
    
    @Published var pickers: [Int] = [0, 1]
    @Published var pickerSelection: Int = 0 {
        didSet {
            selectionLeague(pickerSelection)
        }
    }
    
    let usecase: StandingsUseCase
    
    init(usecase: StandingsUseCase) {
        self.usecase = usecase
    }
    
    func selectionLeague(_ index: Int) {
        if index == 0 {
            if let american {
                self.alWildCardRank = american.wildcardRank
            }
        } else {
            if let national {
                self.alWildCardRank = national.wildcardRank
            }
        }
    }
    
    func retrieve() async {
        if let standings = await usecase.league() {
            let presenters = StandingsPresenter.create(standings)
            self.american = presenters.american
            self.national = presenters.national
            
            pickerSelection = pickerSelection
        }
    }
}
