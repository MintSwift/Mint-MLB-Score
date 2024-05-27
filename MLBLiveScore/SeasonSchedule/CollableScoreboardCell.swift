import SwiftUI
import MLBPresenter

struct CollableScoreboardCell: View {
    let game: GamePresenter
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                VStack(alignment: .trailing) {
                    TeamInfoView(position: .away, team: game.away)
                }
                
                GameStatusView(game.status)
                
                VStack(alignment: .leading) {
                    TeamInfoView(position: .home, team: game.home)
                    
                }
            }

            
//            if game.status.status == .inProgress {
//                
//            } else if game.status.status == .final {
//                HStack(alignment: .top, spacing: 60) {
//                    VStack(alignment: .trailing) {
//                        DecisionsPitcherView(position: .away, team: game.away)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .trailing)
//                    
//                    VStack(alignment: .leading) {
//                        DecisionsPitcherView(position: .home, team: game.home)
//                    }
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                }
//                
//            } else {
//                HStack(alignment: .top) {
//                    VStack(alignment: .trailing) {
//                        
//                        ProbablePitcherView(pitcher: game.away.probablePitcher)
//                        
//                    }
//                    .frame(maxWidth: .infinity, alignment: .center)
//                    
//                    GameStatusView(game.status)
//                        .opacity(0.0)
//                    
//                    VStack(alignment: .leading) {
//                        
//                        ProbablePitcherView(pitcher: game.home.probablePitcher)
//                        
//                    }
//                    .frame(maxWidth: .infinity, alignment: .center)
//                }
//            }
        }
        .padding(.top, 15)
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    SeasonScheduleView()
}
