import SwiftUI
import Kingfisher
import SwiftDate

import MLBPresenter

struct TeamInfoView: View {
    let position: TeamPosition
    let team: TeamPresenter
    
    var body: some View {
        HStack {
            if position == .away {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(team.locationName)
                    Text(team.teamName)
                }
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.trailing, 5)
            }
            
            if position == .home {
                Text(team.score)
                    .font(.title2)
                    .frame(width: 25, alignment: .center)
            }
        
            KFImage(URL(string: "https://midfield.mlbstatic.com/v1/team/\(team.teamId)/spots/100"))
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .scaledToFit()
            
            if position == .away {
                Text(team.score)
                    .font(.title2)
                    .frame(width: 25, alignment: .center)
            }
            
            if position == .home {
                VStack(alignment: .leading) {
                    Text(team.locationName)
                    Text(team.teamName)
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

