import SwiftUI
import Kingfisher
import SwiftDate

struct DailyDetailView: View {
    @EnvironmentObject var interactor: ScheduleInteractor
//    @State var liveScore: LiveScore? = nil
    @State var isLoading: Bool = false
    
    var timer = Timer.publish(every: 20, on: .main, in: .common).autoconnect()
    let gamePk: String
    init(gamePk: String) {
        print("DailyDetailView", gamePk)
        self.gamePk = gamePk
    }
    
    var body: some View {
        VStack {
            ScoreboardView($interactor.liveScore)
                .padding(.top, 10)
            
            ScrollView {
                
                HStack(alignment: .top, spacing: 0) {
                    DiamondView(runner: interactor.liveScore?.runner)
                        .containerRelativeFrame(.horizontal, count: 100, span: 65, spacing: 0, alignment: .center)
                    
                    Spacer()
                    
                    VStack {
                        OutCountView(outCount: interactor.liveScore?.outCount)
                        
                        Spacer()
                        
                        if let player = interactor.liveScore?.onDeckPlayer,
                           let number = player.number,
                           let name = player.name {
                            HStack {
                                KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(number)/spots/90"))
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                
                                Text(name)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundStyle(.blue)
                                    }
                            }
                            .offset(x: -40)
                        }
                    }
                    .containerRelativeFrame(.horizontal, count: 100, span: 30, spacing: 0, alignment: .top)
                    
                }
                .padding(.top, 30)
                VStack {
                    
                }.frame(height: 30, alignment: .center)
                
                
                VStack(alignment: .leading) {
                    if interactor.liveScore?.inningState == .top || interactor.liveScore?.inningState == .end {
                        
                        if let id = interactor.liveScore?.away.teamId {
                            KFImage(URL(string: "https://midfield.mlbstatic.com/v1/team/\(id)/spots/100"))
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .scaledToFit()
                            .padding(.leading, 5)
                        }
                        BoxScoreView(batters: interactor.liveScore?.awayBatters ?? [], player: interactor.liveScore?.runner?.batter)
                            .padding(.horizontal, 5)
                    } else {
                        
                        if let id = interactor.liveScore?.home.teamId {
                            KFImage(URL(string: "https://midfield.mlbstatic.com/v1/team/\(id)/spots/100"))
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .scaledToFit()
                                .padding(.leading, 5)
                        }
                        
                        BoxScoreView(batters: interactor.liveScore?.homeBatters ?? [], player: interactor.liveScore?.runner?.batter)
                            .padding(.horizontal, 5)
                    }
                }
                
                VStack(alignment: .leading) {
                    if interactor.liveScore?.inningState == .top || interactor.liveScore?.inningState == .end {
                        if let id = interactor.liveScore?.home.teamId {
                            KFImage(URL(string: "https://midfield.mlbstatic.com/v1/team/\(id)/spots/100"))
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .scaledToFit()
                                .padding(.top, 10)
                                .padding(.leading, 5)
                        }
                        PitcherBoxScoreView(players: interactor.liveScore?.homePitchers ?? [], player: nil)
                            .padding(.horizontal, 5)
                            
                    } else {
                        if let id = interactor.liveScore?.away.teamId {
                            KFImage(URL(string: "https://midfield.mlbstatic.com/v1/team/\(id)/spots/100"))
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                                .scaledToFit()
                                .padding(.top, 10)
                                .padding(.leading, 5)
                        }
                        PitcherBoxScoreView(players: interactor.liveScore?.awayPitchers ?? [], player: nil)
                            .padding(.horizontal, 5)
                            
                    }
                }
                Spacer()
            }
            
        }
        .task {
            await interactor.liveGame(id: gamePk)
        }
        .onAppear {
            UIApplication.shared.isIdleTimerDisabled = true
        }
        .onDisappear(perform: {
            UIApplication.shared.isIdleTimerDisabled = false
            Task {
                await interactor.schedule()
            }
        })
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        isLoading = true
                        await interactor.liveGame(id: gamePk)
                        isLoading = false
                    }
                } label: {
                    Image(systemName: "arrow.circlepath")
                }
            }
        }
        .onReceive(timer, perform: { _ in
            
            if interactor.liveScore?.status == .final {
                self.timer.upstream.connect().cancel()
                UIApplication.shared.isIdleTimerDisabled = false
            } else {
                Task {
                    await interactor.liveGame(id: gamePk)
                }
            }
        })
    }
}

