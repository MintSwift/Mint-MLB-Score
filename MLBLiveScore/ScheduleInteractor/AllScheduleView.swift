import SwiftUI

struct AllScheduleView: View {
    @StateObject var interactor = ModuleScheduleInteractor.create()
    
    var body: some View {
        Text("\(interactor.schedules.count)")
            .onAppear {
                interactor.retrieveSchedule()
            }
    }
}
