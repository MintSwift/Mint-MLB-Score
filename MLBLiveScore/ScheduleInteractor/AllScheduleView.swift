import SwiftUI

struct AllScheduleView: View {
    @StateObject var interactor = ModuleScheduleInteractor.create()
    
    var body: some View {
        NavigationSplitView {
            AllScheduleSidebar()
        } detail: {
            
        }
        .environmentObject(interactor)
        .onAppear {
            interactor.retrieveSchedule()
        }
    }
}

#Preview {
    AllScheduleView()
}
