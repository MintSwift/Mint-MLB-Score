import SwiftUI
import SwiftDate


struct TeamScheduleView: View {
    @EnvironmentObject var interactor: ScheduleInteractor
    
    var body: some View {
        NavigationSplitView {
            TeamScheduleSidebarView()
        } detail: {
            if let selection = interactor.planSelection {
                DailyDetailView(gamePk: selection)
            }
        }
    }
}
