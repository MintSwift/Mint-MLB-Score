import SwiftUI
import MLBPresenter

struct ScoreboardCell: View {
    let game: GamePresenter
    
    var body: some View {
        HStack {
            VStack {
                HStack {
                    VStack(alignment: .trailing) {
                        TeamInfoView(position: .away, team: game.away)
                    }
                    
                    GameStatusView(game.status)
                    
                    VStack(alignment: .leading) {
                        TeamInfoView(position: .home, team: game.home)
                        
                    }
                }
                
                HStack(alignment: .top) {
                    VStack(alignment: .trailing) {
                        if game.status.status == .final {
                            DecisionsPitcherView(position: .away, team: game.away)
                        } else if game.status.status == .live || game.status.status == .inProgress {
                            
                        } else {
                            ProbablePitcherView(pitcher: game.away.probablePitcher)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    GameStatusView(game.status)
                        .opacity(0.0)
                    
                    VStack(alignment: .leading) {
                        if game.status.status == .final {
                            DecisionsPitcherView(position: .home, team: game.home)
                        } else if game.status.status == .live || game.status.status == .inProgress {
                            
                        } else {
                            ProbablePitcherView(pitcher: game.home.probablePitcher)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
                
                if game.status.status == .inProgress ||
                    game.status.status == .warmup {
                    LineScoreBoardView(linescore: game.linescore,
                                       awayTeamName: game.away.abbreviation,
                                       homwTeamName: game.home.abbreviation)
                }
                
            }
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .clipShape(.rect(cornerRadius: 5))
            .padding(5)
            .shadow(color: .black.opacity(0.3), radius: 3, x: 3, y: 3)
        }
    }
}


#Preview {
    SeasonScheduleView()
}
