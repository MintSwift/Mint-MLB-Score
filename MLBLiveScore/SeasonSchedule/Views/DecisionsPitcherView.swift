import SwiftUI
import MLBPresenter

struct DecisionsPitcherView: View {
    let position: TeamPosition
    let team: TeamPresenter

    var body: some View {
        VStack(alignment: position == .away ? .trailing : .leading, spacing: 2) {
            if let winnerPitcher = team.winner {
                VStack {
                    HStack {
                        if position == .away {
                            Text(winnerPitcher.name)
                                .font(.caption2)
                        }
                        
                        Image(systemName: "w.square.fill")
                            .resizable()
                            .foregroundStyle(.red)
                            .frame(width: 12, height: 12, alignment: .center)
                        
                        if position == .home {
                            Text(winnerPitcher.name)
                                .font(.caption2)
                        }
                        
                    }
                    
                    if position == .away {
                        Text(winnerPitcher.recordSummary)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    
                    if position == .home {
                        Text(winnerPitcher.recordSummary)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                }
            }
            
            if let savePitcher = team.save {
                VStack {
                    HStack {
                        if position == .away {
                            Text(savePitcher.name)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        
                        Image(systemName: "s.square.fill")
                            .resizable()
                            .foregroundStyle(.blue)
                            .frame(width: 12, height: 12, alignment: .center)
                        
                        if position == .home {
                            Text(savePitcher.name)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    if position == .away {
                        Text(savePitcher.recordSummary)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    
                    if position == .home {
                        Text(savePitcher.recordSummary)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                }
            }
            
            if let loserPitcher = team.loser {
                VStack {
                    HStack {
                        if position == .away {
                            Text(loserPitcher.name)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                        
                        Image(systemName: "l.square.fill")
                            .resizable()
                            .foregroundStyle(.gray)
                            .frame(width: 12, height: 12, alignment: .center)
                        
                        if position == .home {
                            Text(loserPitcher.name)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                    
                    if position == .away {
                        Text(loserPitcher.recordSummary)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                    
                    if position == .home {
                        Text(loserPitcher.recordSummary)
                            .font(.caption2)
                            .foregroundStyle(.tertiary)
                    }
                }
            }
        }
        
    }
}
