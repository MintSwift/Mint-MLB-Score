import SwiftUI
import Kingfisher
import SwiftDate
import MLBPresenter

struct AllScheduleCell: View {
    let game: GamePresenter
    
    init(_ game: GamePresenter) {
        self.game = game
    }
    
    var body: some View {
        HStack(spacing: 0) {
            VStack(alignment: .trailing) {
                Text(game.away.probablePitcher?.name ?? "")
            }
            .containerRelativeFrame(.horizontal, count: 30, span: 12, spacing: 0)
            
            GameStatusView(game.status)
                .containerRelativeFrame(.horizontal, count: 30, span: 4, spacing: 0)
            
            VStack(alignment: .leading) {
                Text(game.home.probablePitcher?.name ?? "")
            }
            .containerRelativeFrame(.horizontal, count: 30, span: 12, spacing: 0)
        }
    }
}

