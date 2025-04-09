import SwiftUI
import Kingfisher
import SwiftDate
import MLBPresenter

struct LiveScoreView: View {
    @EnvironmentObject var interactor: SeasonInteractor
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    var game: GamePresenter

    init(game: GamePresenter) {
        self.game = game
    }

    var body: some View {
        ScrollView {
            if let liveGame = interactor.liveGame {
                LineScoreBoardView(
                    linescore: liveGame.linescore,
                    awayTeamName: game.away.abbreviation,
                    homwTeamName: game.home.abbreviation
                )
                .padding(.bottom, 10)
                
                lineup
                
                
                if liveGame.status.status != .final {
                    HStack {
                        DiamondGroundView(liveGame.offense)
                            .containerRelativeFrame(.horizontal, count: 10, span: 5, spacing: 0)
                        
                        OutCountView(
                            outCount: OutCount(
                                balls: liveGame.count.balls,
                                strikes: liveGame.count.strikes,
                                outs: liveGame.count.outs
                            )
                        )
                        .containerRelativeFrame(.horizontal, count: 10, span: 4, spacing: 0)
                        
                    }
                }
            }
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
                        await interactor.live(pk: game.gameId)
                    }
                    count = 0
                } label: {
                    ZStack {
                        Text("\(30 - count)")
                            .font(.footnote)
                        
                        Image(systemName: "arrow.circlepath")
                    }
                }

            }
        }
        .onReceive(timer) { out in
            if game.status.status == .final {
             self.timer.upstream.connect().cancel()
            } else {
                if count >= 30 {
                    Task {
                        await interactor.live(pk: game.gameId)
                    }
                    count = 0
                } else {
                    count += 1
                }
            }
        }
    }
    
    @ViewBuilder
    var lineup: some View {
        if let liveGame = interactor.liveGame {
            if liveGame.status.status == .final {
                BatterLineUp(
                    liveGame.away.batters,
                    offense: liveGame.offense,
                    defense: liveGame.defense,
                )
                BatterLineUp(
                    liveGame.home.batters,
                    offense: liveGame.offense,
                    defense: liveGame.defense,
                )
            } else if liveGame.status.inningState == .top || liveGame.status.inningState == .end {
                BatterLineUp(
                    liveGame.away.batters,
                    offense: liveGame.offense,
                    defense: liveGame.defense,
                )
            } else {
                BatterLineUp(
                    liveGame.home.batters,
                    offense: liveGame.offense,
                    defense: liveGame.defense,
                )
            }
            
        }
        
    }
}
