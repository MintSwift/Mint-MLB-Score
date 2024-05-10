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
                                NavigationLink {
                                    Detail(game: game)
                                        .environmentObject(interactor)
                                } label: {
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
            
        }
    }
}

#Preview {
    ContentView()
}
