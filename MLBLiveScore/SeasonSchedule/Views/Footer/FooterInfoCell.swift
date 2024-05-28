import SwiftUI
import MLBPresenter

struct PitcherInfoView: View {
    let game: GamePresenter
    
    var body: some View {
        if game.status.status == .inProgress {
            
        } else if game.status.status == .final {
            DecisionsContainerView(game: game)
        } else {
            ProbableContainerView(game: game)
        }
    }
}
