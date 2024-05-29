import Foundation

import MLBDomain
import MLBAPIDataSource
import MLBStatsAPI
import MLBPresenter

@MainActor
class SeasonInteractor: ObservableObject {
    static func create() -> SeasonInteractor {
        let provier = MLBProvider()
//        let provier = MLBMockProvider()
        
        let dataSource = BaseScheduleDataSource(provier: provier)
        let repository = BaseScheduleRepository(dataSource: dataSource)
        let usecase = BaseScheduleUseCase(repository: repository)
        return SeasonInteractor(usecase: usecase)
    }
    
    @Published var schedules: [SchedulePresenter] = []
    @Published var selection: GamePresenter? = nil
    
    @Published var liveGame: LiveGamePresenter? = nil

    
    let usecase: ScheduleUseCase
    
    init(usecase: ScheduleUseCase) {
        self.usecase = usecase
    }
    
    func retrieveSchedule() async {
        let schedules = await usecase.all()
        let presenters = SchedulePresenter.create(schedules)
        self.schedules = presenters
    }
    
    func live(pk: Int) async {
        if let schedules = await usecase.live(pk: pk) {
            self.liveGame = LiveGamePresenter.create(schedules)
        }
    }
}
