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
                        .frame(height: 30, alignment: .center)
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowSeparator(.hidden)
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
