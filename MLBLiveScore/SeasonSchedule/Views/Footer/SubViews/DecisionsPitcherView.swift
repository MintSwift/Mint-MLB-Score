import SwiftUI
import MLBPresenter
import Kingfisher

struct DecisionsPitcherView: View {
    let position: TeamPosition
    let team: TeamPresenter

    var body: some View {
        VStack(alignment: position == .away ? .trailing : .leading, spacing: 5) {
            if let winnerPitcher = team.winner {
                PitcherView(position: position, decisions: .winner, player: winnerPitcher)
            }
            
            if let savePitcher = team.save {
                PitcherView(position: position, decisions: .save, player: savePitcher)
            }
            
            if let loserPitcher = team.loser {
                PitcherView(position: position, decisions: .loser, player: loserPitcher)
            }
        }
        .padding(.horizontal, 10)
    }
}

#Preview {
    SeasonScheduleView()
}

enum DecisionsPitcherType {
    case winner
    case save
    case loser
    
    func text() -> String {
        switch self {
        case .winner:
            return "w"
        case .save:
            return "s"
        case .loser:
            return "l"
        }
    }
    
    func color() -> Color {
        switch self {
        case .winner:
            return .red
        case .save:
            return .blue
        case .loser:
            return .gray
        }
    }
}

struct PitcherView: View {
    let position: TeamPosition
    let decisions: DecisionsPitcherType
    let player: PlayerPresenter?

    var body: some View {
        VStack(alignment: position == .away ? .trailing : .leading, spacing: 2) {
            if let player = player {
                HStack(alignment: .top) {
                    if position == .away {
                        VStack(alignment: .trailing) {
                            HStack(alignment: .top) {
                                Text(player.name)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                    .font(.caption2)
                                
                                Image(systemName: "\(decisions.text()).square.fill")
                                    .resizable()
                                    .foregroundStyle(decisions.color())
                                    .frame(width: 12, height: 12, alignment: .center)
                            }
                            if decisions == .save {
                                Text("\(player.saves ?? "-") | \(player.era) ERA")
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            } else {
                                Text(player.recordSummary)
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                            
                        }
                    }
                    KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(player.id)/silo/80"))
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30, alignment: .center)
                    
                    if position == .home {
                        VStack(alignment: .leading) {
                            HStack(alignment: .top) {
                                Image(systemName: "\(decisions.text()).square.fill")
                                    .resizable()
                                    .foregroundStyle(decisions.color())
                                    .frame(width: 12, height: 12, alignment: .center)

                                Text(player.name)
                                    .lineLimit(1)
                                    .minimumScaleFactor(0.8)
                                    .font(.caption2)
                            }
                        
                            if decisions == .save {
                                Text("\(player.saves ?? "-") | \(player.era) ERA")
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            } else {
                                Text(player.recordSummary)
                                    .font(.caption2)
                                    .foregroundStyle(.tertiary)
                            }
                        }
                    }
                    
                }
            }
        }
    }
}

