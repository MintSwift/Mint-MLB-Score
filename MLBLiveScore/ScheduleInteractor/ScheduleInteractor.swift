import Foundation

import MLBDomain
import MLBAPIDataSource
import MLBStatsAPI
import MLBPresenter

@MainActor
class ModuleScheduleInteractor: ObservableObject {
    static func create() -> ModuleScheduleInteractor {
        let provier = MLBProvider()
        let dataSource = BaseScheduleDataSource(provier: provier)
        let repository = BaseScheduleRepository(dataSource: dataSource)
        let usecase = BaseScheduleUseCase(repository: repository)
        return ModuleScheduleInteractor(usecase: usecase)
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
