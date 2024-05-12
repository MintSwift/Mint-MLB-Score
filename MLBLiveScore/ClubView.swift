import SwiftUI
import Kingfisher
import SwiftDate

enum Stadium {
    case home
    case away
}

struct ClubView: View {
    let stadium: Stadium
    let team: Team
    
    var body: some View {
        HStack {
            if stadium == .away {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(team.locationName)
                    Text(team.clubName)
                }
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.trailing, 5)
            }
            
            KFImage(URL(string: "https://a.espncdn.com/i/teamlogos/mlb/500/\(team.symbol).png"))
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .scaledToFit()
            
            
            if stadium == .home {
                
                VStack(alignment: .leading) {
                    Text(team.locationName)
                    Text(team.clubName)
                }
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.leading, 5)
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
