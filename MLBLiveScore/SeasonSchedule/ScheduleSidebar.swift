import SwiftUI

struct ScheduleSidebar: View {
    @EnvironmentObject var interactor: SeasonInteractor
    
    var body: some View {
        List(selection: $interactor.selection) {
            ForEach(interactor.schedules) { schedule in
                Section {
                    ForEach(schedule.games) { game in
                        ZStack {
                            NavigationLink(value: game) {
                                EmptyView()
                            }
                            .opacity(0.0)
                            
                            ScoreboardCell(game: game)
                        }
//                        Button {
//                            interactor.selection = game
//                        } label: {
//                        }
//                        .buttonStyle(.plain)
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
        .navigationDestination(item: $interactor.selection) { selection in
            LiveScoreView(game: selection)
        }
    }
}


#Preview {
    SeasonScheduleView()
}
