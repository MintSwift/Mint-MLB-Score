import SwiftUI

struct SeasonScheduleView: View {
    @StateObject var interactor = SeasonInteractor.create()
    
    var body: some View {
        NavigationSplitView {
            ScheduleSidebar()
        } detail: {
            
        }
        .environmentObject(interactor)
        .onAppear {
            Task {
              await interactor.retrieveSchedule()
            }
        }
    }
}
