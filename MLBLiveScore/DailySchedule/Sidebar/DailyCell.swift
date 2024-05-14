import SwiftUI
import Kingfisher
import SwiftDate

struct DailyCell: View {
    var game: Game

    init(_ game: Game) {
        self.game = game
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .trailing) {
                TeamView(stadium: .away, team: game.away, score: game.awayScore)
            }
            .containerRelativeFrame(.horizontal, count: 30, span: 12, spacing: 0)
            
            GameStateView(game: game)
                .containerRelativeFrame(.horizontal, count: 30, span: 4, spacing: 0)
            
            VStack(alignment: .leading) {
                TeamView(stadium: .home, team: game.home, score: game.homeScore)
            }
            .containerRelativeFrame(.horizontal, count: 30, span: 12, spacing: 0)
        }
    }
}
