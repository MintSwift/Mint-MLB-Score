import SwiftUI
import Kingfisher
import SwiftDate

struct AwayScoreView: View {
    let scoreboard: ScoreboardProtocol
    
    init(scoreboard: ScoreboardProtocol) {
        self.scoreboard = scoreboard
    }
    
    var body: some View {
        HStack {
            Spacer()
            
            VStack(alignment: .leading) {
                Text(scoreboard.franchiseName)
                Text(scoreboard.teamName)
            }
            .font(.caption)
            .lineLimit(1)
            .minimumScaleFactor(0.8)
            .padding(.leading, 5)
            
            KFImage(URL(string: "https://a.espncdn.com/i/teamlogos/mlb/500/\(scoreboard.symbolCode).png"))
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .scaledToFit()
            
            
            Text(scoreboard.score)
                .font(.title2)
                .frame(width: 25, alignment: .leading)
                .overlay(alignment: .top, content: {
                    if scoreboard.isWinner == true {
                        Circle()
                            .foregroundStyle(.red)
                            .frame(width: 7, height: 7, alignment: .center)
                            .opacity(0.6)
                            .offset(y: -5)
                    }
                })
        }
    }
}
