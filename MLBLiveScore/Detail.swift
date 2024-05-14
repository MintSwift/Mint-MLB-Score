//import SwiftUI
//import Kingfisher
//import SwiftDate
//
//struct Detail: View {
//    @EnvironmentObject var interactor: Interactor
//    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
//    var game: Game
//    
//    init(game: Game) {
//        self.game = game
//    }
//    
//    var body: some View {
//        ScrollView {
//            
//            VStack {
//                Text(verbatim: "\(game.gameId)")
//                ContentCell(game: $interactor.selection)
//                
////                DiamondGroundView(runner: interactor.liveScore?.runner)
//       
////                OutCountView(outCount: interactor.liveScore?.outCount)
////                    .padding(.top, 25)
//                BoxScoreView(boxscore: .init(get: {
//                    return interactor.liveScore?.boxScore
//                }, set: { _ in }))
//                
//                Spacer()
//            }
//        }
//        .onAppear {
//            Task {
//                await interactor.detail(id: game.gameId)
//            }
//        }
//        .onDisappear(perform: {
//            self.timer.upstream.connect().cancel()
//        })
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                Button {
//                    Task {
//                        await interactor.schedule()
//                        await interactor.detail(id: game.gameId)
//                    }
//                } label: {
//                    Image(systemName: "arrow.circlepath")
//                }
//                
//            }
//        }
//        .onReceive(timer) { out in
//            if game.state == .final {
//             self.timer.upstream.connect().cancel()
//            } else {
//                Task {
//                    await interactor.schedule()
//                    await interactor.detail(id: game.gameId)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
