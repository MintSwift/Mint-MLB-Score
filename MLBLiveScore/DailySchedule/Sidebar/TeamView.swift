import SwiftUI
import Kingfisher
import SwiftDate

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
    
//                    .overlay(alignment: .topLeading, content: {
//                        if team.isWinner == true {
//                            Circle()
//                                .foregroundStyle(.red)
//                                .frame(width: 7, height: 7, alignment: .center)
//                                .opacity(0.8)
//                                .offset(x: 3.5, y: -5)
//                        }
//                    })
            }
        
            KFImage(URL(string: "https://midfield.mlbstatic.com/v1/team/\(team.teamID)/spots/100"))
                .resizable()
                .frame(width: 30, height: 30, alignment: .center)
                .scaledToFit()
            
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
                    
                
//                    .overlay(alignment: .topTrailing, content: {
//                        if team.isWinner == true {
//                            Circle()
//                                .foregroundStyle(.red)
//                                .frame(width: 7, height: 7, alignment: .center)
//                                .opacity(0.8)
//                                .offset(x: -3.5, y: -5)
//                        }
//                    })
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
