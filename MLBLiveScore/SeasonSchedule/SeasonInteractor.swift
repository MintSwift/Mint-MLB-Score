import Foundation

import MLBDomain
import MLBAPIDataSource
import MLBStatsAPI
import MLBPresenter

@MainActor
class SeasonInteractor: ObservableObject {
    static func create() -> SeasonInteractor {
        let provier = MLBProvider()
        let dataSource = BaseScheduleDataSource(provier: provier)
        let repository = BaseScheduleRepository(dataSource: dataSource)
        let usecase = BaseScheduleUseCase(repository: repository)
        return SeasonInteractor(usecase: usecase)
    }
    
    @Published var schedules: [SchedulePresenter] = []
    
    let usecase: ScheduleUseCase
    
    init(usecase: ScheduleUseCase) {
        self.usecase = usecase
    }
    
    func retrieveSchedule() {
        Task {
            let schedules = await usecase.all()
            let presenters = SchedulePresenter.create(schedules)
            self.schedules = presenters
        }
    }
}
