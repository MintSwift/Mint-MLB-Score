import Foundation
import SwiftDate

@Observable
class Interactor {
    var schedules: [Schedule] = []
    
    init() {
        Task {
//            await linescore()
            await schedule()
        }
        
    }
    
    
    func linescore() async {
//        response = await Network.base()
    }
    
    
    func schedule() async {
        let start = Date.now
        
        self.schedules = await Network.schedule(startDate: start)
    }
}
