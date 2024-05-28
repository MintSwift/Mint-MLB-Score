import SwiftUI

struct ScheduleSidebar: View {
    @EnvironmentObject var interactor: SeasonInteractor
    
    var body: some View {
        List {
            ForEach(interactor.schedules) { schedule in
                Section {
                    ForEach(schedule.games) { game in
                        ScoreboardCell(game: game)
                    }
                } header: {
                    Text(schedule.date)
                        .frame(height: 20, alignment: .center)
                        .padding(.leading, 10)
                }
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.grouped)
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
            await interactor.retrieveSchedule()
        }
    }
}


#Preview {
    SeasonScheduleView()
}
