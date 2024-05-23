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
                    if game.state == .warmup {
                        Text("Warmup")
                    } else {
                        Text(game.inningState.text())
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.horizontal, 5)
                
                VStack {
                    TeamView(stadium: .home, team: game.home, score: game.homeScore)
                }
                
            }
            
            HStack {
                VStack(spacing: 5) {
                    Text(" ")
                        .font(.callout)
                    
                    if let team = MLBTeam.all.first(where: { $0 .code == Int(game.away.teamID) }) {
                        Text(team.abbreviation.uppercased())
                            .frame(maxWidth: .infinity)
                            .font(.callout)
                            
                    }
                 
                    if let team = MLBTeam.all.first(where: { $0 .code == Int(game.home.teamID) }) {
                        Text(team.abbreviation.uppercased())
                            .frame(maxWidth: .infinity)
                            .font(.callout)
                    }
                }
                
                ForEach(game.innings) { inning in
                    VStack(spacing: 5) {
                        Text(String( inning.num ))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        
                        Text( inning.away.runs == nil ? " " : String(inning.away.runs ?? 0))
                            .font(.body)
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
                            .font(.body)
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
            .padding(.top, 5)
        }
    }
}

