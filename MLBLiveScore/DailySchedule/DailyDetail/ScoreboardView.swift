import SwiftUI
import Kingfisher
import SwiftDate

struct ScoreboardView: View {
    @Binding var board: LiveScore?

    init(_ board: Binding<LiveScore?>) {
        _board = board
    }
    
    var body: some View {
        HStack(spacing: 0) {
            HStack {
                VStack {
                    Text(board?.away.teamName ?? "")
                        .font(.body)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .padding(.trailing, 5)

                    HStack {
                        Text(String( board?.away.wins ?? "-") )
                        Text("-")
                        Text(String( board?.away.losses ?? "-"))
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                }
                
                if let id = board?.away.teamId {
                    KFImage(URL(string: "https://midfield.mlbstatic.com/v1/team/\(id)/spots/100"))
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .scaledToFit()
                }
                
                Text(board?.awayScore ?? "-")
                    .font(.title3)
                    .frame(width: 30, alignment: .center)
            }
            .overlay(alignment: .bottom, content: {
                if board?.inningState == .top {
                    Capsule()
                        .foregroundStyle(.blue)
                        .frame(height: 4, alignment: .center)
                        .offset(y: 10)
                }
            })
            .containerRelativeFrame(.horizontal, count: 100, span: 45, spacing: 0)
            
            
            VStack {
//                if let reason = game.stateReason {
//                    Text(reason)
//                        .font(.caption2)
//                } else if game.state == .final {
//                    Text(game.state.rawValue)
//                        .font(.caption2)
//                } else if game.state == .preview {
//                    VStack {
//                        Text(game.date.toFormat("a", locale: Locales.korean))
//                            .font(.caption2)
//                        Text(game.date.toFormat("hh:mm", locale: Locales.korean))
//                    }
//                    .font(.footnote)
//                } else {
                    VStack {
                        Text(board?.currentInning ?? "")
                        Text(board?.inningState.text() ?? "")
                    }
                    .font(.footnote)
//                }
            }
            .containerRelativeFrame(.horizontal, count: 100, span: 10, spacing: 0)
            
//            GameStateView(gameData: gameData)
            
            HStack {
                Text(board?.homeScore ?? "-")
                    .font(.title3)
                    .frame(width: 30, alignment: .center)
                
                if let id = board?.home.teamId {
                    KFImage(URL(string: "https://midfield.mlbstatic.com/v1/team/\(id)/spots/100"))
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .scaledToFit()
                }
                
                VStack {
                    Text(board?.home.teamName ?? "")
                        .font(.body)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .padding(.trailing, 5)

                    HStack {
                        Text(String( board?.home.wins ?? "-") )
                        Text("-")
                        Text(String( board?.home.losses ?? "-"))
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                }
            
            }
            .overlay(alignment: .bottom, content: {
                if board?.inningState == .bottom {
                    Capsule()
                        .foregroundStyle(.blue)
                        .frame(height: 4, alignment: .center)
                        .offset(y: 10)
                }
            })
            .containerRelativeFrame(.horizontal, count: 100, span: 45, spacing: 0)
        }
    }
}
