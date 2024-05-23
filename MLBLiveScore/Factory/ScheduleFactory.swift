//import Foundation
//import MLBDomain
//import MLBAPIUseCase
//import MLBAPIDataSource
//import MLBStatsAPI
//import MLBResponse
//
//class ScheduleFactory {
//    
//    @MainActor
//    static func create() -> ModuleScheduleInteractor {
//        let usecase = ScheduleFactory.createUseCase()
//        return ModuleScheduleInteractor(usecase: usecase)
//    }
//    
//    static func createUseCase() -> ScheduleUseCaseProtocol {
//        let dataSource = ScheduleFactory.createDataSource()
//        let usecase = ScheduleUseCase(dataSource: dataSource)
//        return usecase
//    }
//    
//    static func createDataSource() -> ScheduleDataSourceProtocol {
//        let provier = MLBProvider()
//        let dataSource = ScheduleDataSource(provier: provier)
//        return dataSource
//    }
//}
