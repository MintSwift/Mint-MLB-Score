
import Foundation
import MLBAPIUseCase
import MLBPresenter
import MLBAPIDataSource
import MLBStatsAPI

@MainActor
class ModuleScheduleInteractor: ObservableObject {
    static func create() -> ModuleScheduleInteractor {
        let provier = MLBProvider()
        let dataSource = ScheduleDataSource(provier: provier)
        let usecase = ScheduleUseCase(dataSource: dataSource)
        return ModuleScheduleInteractor(usecase: usecase)
    }
    
    @Published var schedules: [SchedulePresenter] = []
    
    let usecase: ScheduleUseCaseProtocol
    
    init(usecase: ScheduleUseCaseProtocol) {
        self.usecase = usecase
    }
    
    func retrieveSchedule() {
        Task {
            let items = await usecase.all()
            if let items {
                let presenters = SchedulePresenter.create(plan: items)
                schedules = presenters
            }
        }
    }
}
