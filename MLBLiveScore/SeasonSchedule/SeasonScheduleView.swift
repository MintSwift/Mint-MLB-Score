import SwiftUI

struct SeasonScheduleView: View {
    @StateObject var interactor = SeasonInteractor.create()
    
    var body: some View {
        NavigationStack {
            ScheduleSidebar()
        }
//        NavigationSplitView {
//            ScheduleSidebar()
//        } detail: {
//            if let selection = interactor.selection {
//                LiveScoreView(game: selection)
//            }
//        }
        .environmentObject(interactor)
        .onAppear {
            Task {
              await interactor.retrieveSchedule()
            }
        }
    }
}
