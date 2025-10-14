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
                
                VStack {
                    if game.type.isPostSeason() {
                        Text(game.description)
                            .font(.caption2)
                        HStack(spacing: 2) {
                            Text(game.away.seasonRecord.wins)
                            Text("-")
                            Text(game.home.seasonRecord.wins)
                        }
                        .font(.caption2)
                        .padding(.bottom, 5)
                    }
                    
                    GameStatusView(game.status)
                }
                
                VStack(alignment: .leading) {
                    TeamInfoView(position: .home, team: game.home)
                    
                }
            }
        }
        .foregroundStyle(game.ifNecessary ? .primary : .secondary)
        .padding(.top, 15)
    }
}

#Preview {
    SeasonScheduleView()
}
