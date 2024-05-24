import SwiftUI
import MLBPresenter

struct ScoreboardCell: View {
    let game: GamePresenter
    
    var body: some View {
        HStack {
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .trailing) {
                        TeamInfoView(position: .away, team: game.away)
                        
                        if game.status.status == .scheduled {
                            ProbablePitcherView(pitcher: game.away.probablePitcher)
                        } else if game.status.status == .final {
                            DecisionsPitcherView(position: .away, team: game.away)
                                .padding(.trailing, 10)
//                                .background(.yellow)
                        }
                        
                    }
//                    .background(.red)
                    
                    GameStatusView(game.status)
                    
                    VStack(alignment: .leading) {
                        TeamInfoView(position: .home, team: game.home)
                        
                        if game.status.status == .scheduled {
                            ProbablePitcherView(pitcher: game.home.probablePitcher)
                        } else if game.status.status == .final {
                            DecisionsPitcherView(position: .home, team: game.home)
                                .padding(.leading, 10)
//                                .background(.red)
                        }
                    }
//                    .background(.blue)
                }
                
                Text("스코어 보드")
            }
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.white)
            .clipShape(.rect(cornerRadius: 10))
            .padding(5)
            .shadow(color: .black.opacity(0.4), radius: 5, x: 5, y: 5)
        }
    }
}


#Preview {
    SeasonScheduleView()
}
