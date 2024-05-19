import SwiftUI

struct WidgetLiveStatusView: View {
    var game: Game?
    
    var body: some View {
        HStack {
            if let game {
                VStack {
                    TeamView(stadium: .away, team: game.away, score: game.awayScore)
                }
                
                innings
                
                VStack {
                    TeamView(stadium: .home, team: game.home, score: game.homeScore)
                }
            }
        }
    }
    
    
    var innings: some View {
        InningsView()
    }
}

enum Stadium {
    case home
    case away
}

struct TeamView: View {
    let stadium: Stadium
    let team: Team
    let score: String
    
    init(stadium: Stadium, team: Team, score: String) {
        self.stadium = stadium
        self.team = team
        self.score = score
    }
    
    var body: some View {
        HStack {
            if stadium == .away {
                Spacer()
                
                VStack(alignment: .trailing) {
                    Text(team.franchiseName)
                    Text(team.teamName)
                }
                .font(.caption)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.trailing, 5)
            }
            
            if stadium == .home {
                Text(score)
                    .font(team.isWinner == true ? .title2 : .subheadline)
                    .frame(width: 25, alignment: .center)
                    .background {
                        if team.isWinner == true {
                            Circle()
                                .foregroundStyle(.red)
                                .opacity(0.5)
                        }
                    }
            }
            if let team = MLBTeam.all.first(where: { $0 .code == Int(team.teamID) }) {
                Image(team.abbreviation)
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .scaledToFit()
            }
            
            if stadium == .away {
                Text(score)
                    .font(team.isWinner == true ? .title2 : .subheadline)
                    .frame(width: 25, alignment: .center)
                    .background {
                        if team.isWinner == true {
                            Circle()
                                .foregroundStyle(.red)
                                .opacity(0.5)
                        }
                    }
                
                if stadium == .home {
                    
                    VStack(alignment: .leading) {
                        Text(team.franchiseName)
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
}
