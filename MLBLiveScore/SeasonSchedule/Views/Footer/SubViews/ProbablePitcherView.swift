import SwiftUI
import MLBPresenter
import Kingfisher

struct ProbablePitcherView: View {
    let position: TeamPosition
    let pitcher: PlayerPresenter?
    
    var body: some View {
        if let pitcher {
            if position == .away {
                away(pitcher: pitcher)
            }
            
            if position == .home {
                homw(pitcher: pitcher)
            }
        } else {
            Text("TBD")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
    
    func away(pitcher: PlayerPresenter) -> some View {
        HStack {
            VStack(alignment: .trailing) {
                HStack(spacing: 4) {
                    Text(pitcher.name)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                    
                    Image(systemName: "p.square.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.secondary)
                }
                
                Text(pitcher.recordSummary)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            
            KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(pitcher.id)/silo/80"))
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
        }
        .frame(alignment: .trailing)
    }
    
    func homw(pitcher: PlayerPresenter) -> some View {
        HStack {
            KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(pitcher.id)/silo/80"))
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30, alignment: .center)
            
            VStack(alignment: .leading) {
                HStack(spacing: 4) {
                    Image(systemName: "p.square.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.secondary)
                    
                    Text(pitcher.name)
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                
                Text(pitcher.recordSummary)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
        }
        .frame(alignment: .leading)
    }
}
