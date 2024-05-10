import SwiftUI
import Kingfisher

struct ContentView: View {
    @StateObject var interactor = Interactor()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(interactor.schedules) { schedule in
                    ForEach(schedule.dates) { date in
                        Section {
                            ForEach(date.games) { game in
                                ZStack {
                                    NavigationLink(value: game) {
                                        EmptyView()
                                    }
                                    .opacity(0.0)
                                    
                                    ContentCell(game: game)
                                }
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
            .navigationDestination(for: Game.self) { game in
                Detail(game: game)
                    .environmentObject(interactor)
            }
        }
        
    }
}

#Preview {
    ContentView()
}
