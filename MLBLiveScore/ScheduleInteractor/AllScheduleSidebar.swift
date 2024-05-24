import SwiftUI
import SwiftDate

struct AllScheduleSidebar: View {
    @EnvironmentObject var interactor: ModuleScheduleInteractor
    
    var body: some View {
        List {
            ForEach(interactor.schedules) { schedule in
                Section {
                    ForEach(schedule.games) { game in
                        Button {
//                            interactor.selection = game.pk
                        } label: {
                            AllScheduleCell(game)
//                            DailyCell(game)
                        }
                        .buttonStyle(.plain)
                    }
                    .listRowBackground(Color.clear)
                    
                    
                } header: {
                    Text(schedule.date)
                }
                
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image("MLB_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20, alignment: .center)
                }
            }
            
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Schedule")
                }
            }
        }
        .refreshable {
//            await interactor.schedule()
        }
    }
}
