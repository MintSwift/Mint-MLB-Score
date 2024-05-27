import SwiftUI
import MLBPresenter

struct ProbableContainerView: View {
    let game: GamePresenter
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .trailing) {
                
                ProbablePitcherView(pitcher: game.away.probablePitcher)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            GameStatusView(game.status)
                .opacity(0.0)
            
            VStack(alignment: .leading) {
                
                ProbablePitcherView(pitcher: game.home.probablePitcher)
                
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
