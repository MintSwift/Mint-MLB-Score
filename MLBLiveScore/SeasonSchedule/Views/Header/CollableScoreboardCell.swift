import SwiftUI
import MLBPresenter

struct HeaderScoreboardCell: View {
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
        }
        .padding(.top, 15)
    }
}

#Preview {
    SeasonScheduleView()
}
