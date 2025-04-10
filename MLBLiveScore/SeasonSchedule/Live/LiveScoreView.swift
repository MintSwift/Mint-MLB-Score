import SwiftUI
import Kingfisher
import SwiftDate
import MLBPresenter

struct LiveScoreView: View {
    @EnvironmentObject var interactor: SeasonInteractor
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var count: Int = 0
    @State private var selectedTab = 0
    var game: GamePresenter

    init(game: GamePresenter) {
        self.game = game
    }

    var body: some View {
        VStack(spacing: 0) {
            if let liveGame = interactor.liveGame {
                HeaderScoreboardCell(game: game)
                
                LineScoreBoardView(
                    linescore: liveGame.linescore,
                    awayTeamName: game.away.abbreviation,
                    homwTeamName: game.home.abbreviation
                )
                .padding(.bottom, 10)
                
                Picker("", selection: $selectedTab) {
                    ForEach(0...1, id: \.self) { element in
                        Text(element == 0 ?
                             "\(game.away.locationName) \(game.away.teamName)" :
                                "\(game.home.locationName) \(game.home.teamName)")
                            .fontWeight(selectedTab == element ? .bold : .regular)
                            .padding(.vertical, 12)
                            .frame(maxWidth: .infinity)
                            .tag(element)
                        
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal, 12)
                .padding(.vertical, 10)
                
                TabView(selection: $selectedTab) {
                    VStack {
                        BatterLineUp(
                            liveGame.away.batters,
                            offense: liveGame.offense,
                            defense: liveGame.defense,
                        )
                        Spacer()
                    }
                    .tag(0)
                    
                    VStack {
                        BatterLineUp(
                            liveGame.home.batters,
                            offense: liveGame.offense,
                            defense: liveGame.defense,
                        )
                        Spacer()
                    }
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
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
                    .padding(.vertical, 30)
                    .padding(.bottom, 20)
                } else {
                    Spacer()
                }
            }
        }
        .onAppear {
            refresh()
        }
        .onChange(of: interactor.liveGame?.linescore.inningState, { oldValue, newValue in
            if newValue == .middle {
                selectedTab = 1
                refresh()
            } else if newValue == .end {
                selectedTab = 0
                refresh()
            }
            
        })
        .onDisappear(perform: {
            self.timer.upstream.connect().cancel()
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    refresh()
                } label: {
                    ZStack {
                        Text("\(15 - count)")
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
                if count >= 15 {
                    refresh()
                } else {
                    count += 1
                }
            }
        }
    }
    
    func refresh() {
        Task {
            await interactor.live(pk: game.gameId)
        }
        count = 0
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
