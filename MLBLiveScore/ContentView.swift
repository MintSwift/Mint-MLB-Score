import SwiftUI
import Kingfisher

struct ContentView: View {
    var interactor = Interactor()
    
    var body: some View {
        List {
            ForEach(interactor.schedules) { schedule in
                ForEach(schedule.dates) { date in
                    Section {
                        ForEach(date.games) { game in
                            ContentCell(game: game)
                        }
                    } header: {
                        Text(date.date)
                    }
                }
            }
        }
        .listStyle(.grouped)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await interactor.schedule()
                    }
                } label: {
                    Image(systemName: "arrow.circlepath")
                }

            }
        }
    }
}

#Preview {
    ContentView()
}
