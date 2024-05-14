//import SwiftUI
//import Kingfisher
//
//struct ContentView: View {
////    @EnvironmentObject var interactor: Interactor
//    @StateObject var interactor = Interactor()
//    var body: some View {
//        
//
//        NavigationStack {
//            List {
//                ForEach(interactor.schedules) { schedule in
//                    ForEach(schedule.dates) { date in
//                        Section {
//                            ForEach(date.games) { game in
//                                ZStack {
//                                    NavigationLink(value: game) {
//                                        EmptyView()
//                                    }
//                                    .opacity(0.0)
//                                    
//                                    ContentCell(game: .init(get: { game }, set: { _ in }))
//                                }
//                            }
//                        } header: {
//                            Text(date.date)
//                        }
//                    }
//                }
//            }
//            
//            .listStyle(.grouped)
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing) {
//                    Button {
//                        Task {
//                            await interactor.schedule()
//                        }
//                    } label: {
//                        Image(systemName: "arrow.circlepath")
//                    }
//                    
//                }
//            }
////            .navigationDestination(for: Game.self) { game in
////                Detail(game: .init(get: { game }, set: { _ in }))
////                    .environmentObject(interactor)
////            }
//        }
//        
//    }
//}
//
//#Preview {
//    ContentView()
//}
