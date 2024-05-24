import SwiftUI
import MLBPresenter

struct DecisionsPitcherView: View {
    let position: TeamPosition
    let team: TeamPresenter

    var body: some View {
        VStack(alignment: position == .away ? .trailing : .leading, spacing: 2) {
            if let winnerPitcher = team.winner?.name {
                HStack {
                    if position == .away {
                        Text(winnerPitcher)
                            .font(.caption2)
                    }
                        Image(systemName: "w.square.fill")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 12, height: 12, alignment: .center)
                    
                    if position == .home {
                        Text(winnerPitcher)
                            .font(.caption2)
                    }
                    
                }
            }
            
            if let savePitcher = team.save?.name {
                HStack {
                    if position == .away {
                        Text(savePitcher)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    
                    Image(systemName: "s.square.fill")
                        .resizable()
                        .foregroundStyle(.blue)
                        .frame(width: 12, height: 12, alignment: .center)
                    
                    if position == .home {
                        Text(savePitcher)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            
            if let loserPitcher = team.loser?.name {
                HStack {
                    if position == .away {
                        Text(loserPitcher)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    
                    Image(systemName: "l.square.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 12, height: 12, alignment: .center)
                    
                    if position == .home {
                        Text(loserPitcher)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                .frame(height: 30)
            }
        }
        .frame(height: 30)
    }
}
