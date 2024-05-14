import Foundation
import SwiftDate

@MainActor
class ScheduleInteractor: ObservableObject {
//    @Published var sections: [SectionDate] = []
    
    @Published var selection: String? = nil
    
    @Published var liveScore: LiveScore? = nil
    
    @Published var dateSections: [DateSection] = []
    
    
    
    init() {
        Task {
            await schedule()
        }
    }
    
    func schedule() async {
        let start = Date.now - 1.days
        let sections = await ScheduleProvider.fetch(startDate: start)
        
        self.dateSections = sections.map { DateSection($0) }
        
    }
    
    func fetch(_ game: Game) async {
        print("liveGame \(game.pk)")
        if let scoreBoard = await LiveGameProvider.fetch(id: game.pk) {
            liveScore = LiveScore(scoreBoard)
        }
    }
    
    func liveGame(id: String) async {
        print("liveGame \(id)")
        if let scoreBoard = await LiveGameProvider.fetch(id: id) {
            liveScore = LiveScore(scoreBoard)
        }
    }
}
