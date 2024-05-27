import SwiftUI
import MLBPresenter

struct DecisionsContainerView: View {
    let game: GamePresenter
    
    var body: some View {
        HStack(alignment: .top, spacing: 60) {
            VStack(alignment: .trailing) {
                DecisionsPitcherView(position: .away, team: game.away)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            VStack(alignment: .leading) {
                DecisionsPitcherView(position: .home, team: game.home)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
