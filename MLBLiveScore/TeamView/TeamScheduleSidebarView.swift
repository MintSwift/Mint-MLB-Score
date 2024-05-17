import SwiftUI
import SwiftDate

struct TeamScheduleSidebarView: View {
    @EnvironmentObject var interactor: ScheduleInteractor
    
    var body: some View {
        List(selection: $interactor.selection) {
            ForEach(interactor.teamDateSections) { section in
                Section {
                    ForEach(section.games) { game in
                        Button {
                            interactor.selection = game.pk
                        } label: {
                            DailyCell(game)
                        }
                        .buttonStyle(.plain)
                    }
                } header: {
                    Text(section.title)
                }
            }
        }
        .listStyle(.grouped)
        .refreshable {
            await interactor.schedule()
        }
    }
}
