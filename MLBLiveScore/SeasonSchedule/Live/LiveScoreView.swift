import SwiftUI
import Kingfisher
import SwiftDate
import MLBPresenter

struct LiveScoreView: View {
    @EnvironmentObject var interactor: SeasonInteractor
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    var game: GamePresenter

    init(game: GamePresenter) {
        self.game = game
    }

    var body: some View {
        ScrollView {
            BatterLineUp(interactor.liveGame?.away.batters ?? [])
        }
        .onAppear {
            Task {
                await interactor.live(pk: game.gameId)
            }
        }
        .onDisappear(perform: {
            self.timer.upstream.connect().cancel()
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        
                    }
                } label: {
                    Image(systemName: "arrow.circlepath")
                }

            }
        }
//        .onReceive(timer) { out in
//            if game.state == .final {
//             self.timer.upstream.connect().cancel()
//            } else {
//                Task {
//                    
//                }
//            }
//        }
    }
}
