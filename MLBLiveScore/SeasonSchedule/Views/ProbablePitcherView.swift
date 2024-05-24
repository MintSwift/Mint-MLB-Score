import SwiftUI
import MLBPresenter

struct ProbablePitcherView: View {
    let pitcher: PlayerPresenter?
    
    var body: some View {
        if let pitcher {
            VStack {
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
            .frame(alignment: .leading)
        } else {
            Text("TBD")
                .font(.caption2)
                .foregroundStyle(.secondary)
                .lineLimit(1)
                .minimumScaleFactor(0.5)
        }
    }
}
