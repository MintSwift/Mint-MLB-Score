import SwiftUI

struct DailyScheduleView: View {
    @EnvironmentObject var interactor: ScheduleInteractor
    
    var body: some View {
        NavigationSplitView {
            DailySidebar()
        } detail: {
            if let selection = interactor.selection {
                DailyDetailView(gamePk: selection)
            }
        }
        .environmentObject(interactor)
    }
}
