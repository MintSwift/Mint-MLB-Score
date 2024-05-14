import SwiftUI
import Kingfisher
import SwiftDate

struct GameStateView: View {
    let game: Game
    
    var body: some View {
        VStack {
            if let reason = game.stateReason {
                Text(reason)
                    .font(.caption2)
            } else if game.state == .final {
                Text(game.state.rawValue)
                    .font(.caption2)
            } else if game.state == .preview {
                VStack {
                    Text(game.date.toFormat("a", locale: Locales.korean))
                        .font(.caption2)
                    Text(game.date.toFormat("hh:mm", locale: Locales.korean))
                }
                .font(.footnote)
            } else {
                VStack {
                    Text(game.currentInning)
                    Text(game.inningState.text())
                }
                .font(.footnote)
            }
        }   
    }
}
