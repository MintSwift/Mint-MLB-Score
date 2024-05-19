import SwiftUI

struct WLiveView: View {
    var game: Game
    
    var body: some View {
        VStack {
            HStack {
                
                VStack {
                    TeamView(stadium: .away, team: game.away, score: game.awayScore)
                }
                
                VStack {
                    Text(game.currentInning)
                    Text(game.inningState.rawValue)
                }
                .font(.footnote)
                
                VStack {
                    TeamView(stadium: .home, team: game.home, score: game.homeScore)
                }
                
            }
            
            HStack {
                ForEach(game.innings) { inning in
                    VStack {
                        Text(String( inning.num ))
                        Text( inning.away.runs == nil ? " " : String(inning.away.runs ?? 0))
                            .padding(.horizontal, 3)
                            .background {
                                if game.currentInning == inning.ordinalNum && (game.inningState == .top) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .frame(width: 20)
                                        .foregroundStyle(.gray)
                                        .opacity(0.5)
                                }
                            }
                        Text( inning.home.runs == nil ? " " : String(inning.home.runs ?? 0))
                            .padding(.horizontal, 3)
                            .background {
                                if game.currentInning == inning.ordinalNum && (game.inningState == .bottom || game.inningState == .middle) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .frame(width: 20)
                                        .foregroundStyle(.gray)
                                        .opacity(0.5)
                                }
                            }
                    }
                    .frame(width: 20)
                }
                
            }
        }
    }
}

