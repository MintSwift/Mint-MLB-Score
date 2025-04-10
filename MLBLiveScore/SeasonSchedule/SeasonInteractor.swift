import Foundation
import WidgetKit

import MLBDomain
import MLBAPIDataSource
import MLBStatsAPI
import MLBPresenter

import UIKit

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
        
        if let selection {
            let games = presenters.flatMap { $0.games }
            let select = games.first { $0.gameId == selection.gameId }
            self.selection = select
        }
        
        WidgetCenter.shared.reloadAllTimelines()
    }
    
    func live(pk: Int) async {
        if let schedules = await usecase.live(pk: pk) {
            await retrieveSchedule()

            self.liveGame = LiveGamePresenter.create(schedules)
            
            if let liveGame = liveGame {
                if liveGame.status.status != .final {
                    UIApplication.shared.isIdleTimerDisabled = true
                } else {
                    UIApplication.shared.isIdleTimerDisabled = false
                }
            }
        }
    }
}
