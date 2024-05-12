import SwiftUI
import Kingfisher
import SwiftDate

struct ScoreView: View {
    let stadium: Stadium
    let game: Game
    
    var body: some View {
        if stadium == .away {
            if game.state == .final && game.away.score > game.home.score {
                Text("\(game.away.score)")
                    .overlay(alignment: .top, content: {
                        Circle()
                            .foregroundStyle(.red)
                            .frame(width: 5, height: 5, alignment: .center)
                            .opacity(0.6)
                            .offset(y: -5)
                    })
                    .frame(width: 20)
            } else {
                Text("\(game.away.score)")
                    .frame(width: 20)
            }
        } else {
            if game.state == .final && game.away.score < game.home.score {
                Text("\(game.home.score)")
                    .overlay(alignment: .top, content: {
                        Circle()
                            .foregroundStyle(.red)
                            .frame(width: 5, height: 5, alignment: .center)
                            .opacity(0.6)
                            .offset(y: -5)
                    })
                    .frame(width: 20)
            } else {
                Text("\(game.home.score)")
                    .frame(width: 20)
            }
        }
    }
}

#Preview {
    ContentView()
}
