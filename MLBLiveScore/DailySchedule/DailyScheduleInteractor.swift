import Foundation
import SwiftDate

@MainActor
class ScheduleInteractor: ObservableObject {
//    @Published var sections: [SectionDate] = []
    
    @Published var selection: String? = nil
    @Published var planSelection: String? = nil
    
    @Published var liveScore: LiveScore? = nil
    
    @Published var dateSections: [DateSection] = []
    
    @Published var teamDateSections: [DateSection] = []
    
    
    
    init() {
        Task {
            await schedule()
        }
    }
    
    func schedule() async {
        let start = Date.now - 1.days
        let sections = await ScheduleProvider.fetch(startDate: start)
        self.dateSections = sections.map { DateSection($0) }
        
        let items = await TeamScheduleProvider.fetch(teamId: 119)
        self.teamDateSections = items.map { DateSection($0) }
    
    }
    
    func liveGame(id: String) async {
        if let scoreBoard = await LiveGameProvider.fetch(id: id) {
            liveScore = LiveScore(scoreBoard)
        }
    }
}

