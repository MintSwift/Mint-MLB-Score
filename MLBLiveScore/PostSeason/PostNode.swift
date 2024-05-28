import SwiftUI
import Kingfisher

struct PostNode: View {
    let circleWidth: CGFloat
    let space: CGFloat
    let alignment: Alignment
    let teamSpace: CGFloat
    let away: String?
    let home: String?
    let toWinner: Bool
    let bottomWinner: Bool
    
    init(away: String?, home: String?, alignment: Alignment, circleWidth: CGFloat, teamSpace: CGFloat, toWinner: Bool = false, bottomWinner: Bool = false) {
        self.away = away
        self.home = home
        self.circleWidth = circleWidth
        self.alignment = alignment
        space = circleWidth / 10
        self.teamSpace = teamSpace
        self.toWinner = toWinner
        self.bottomWinner = bottomWinner
    }

    var body: some View {
        HStack(spacing: 0) {
            if alignment == .leading {

                VStack {
                    Rectangle()
                        .frame(width: 1, height: circleWidth + (teamSpace * 2) + 20)
                }

                VStack(spacing: circleWidth + (teamSpace * 2) + 20 ) {
                    Rectangle()
                        .frame(width: circleWidth / 7, height: 1)

                    Rectangle()
                        .frame(width: circleWidth / 7, height: 1)
                }
            }
            
            if alignment == .trailing {
                VStack(spacing: circleWidth + (teamSpace * 2) + 20 ) {
                    Rectangle()
                        .frame(width: circleWidth / 7, height: 1)
                        .opacity(toWinner ? 1.0 : 0.0)
                    
                    Rectangle()
                        .frame(width: circleWidth / 7, height: 1)
                        .opacity(bottomWinner ? 1.0 : 0.0)
                    
                }
            }

            VStack(spacing: teamSpace) {
                HStack(spacing: 0) {
                    if let away {
                        Image("C_\(away)")
                            .resizable()
                            .frame(width: circleWidth, height: circleWidth)
                    } else {
                        Circle()
                            .stroke(lineWidth: 2.0)
                            .frame(width: circleWidth, height: circleWidth)
                    }
                }

                Text("1-1")
                    .frame(width: circleWidth, height: 20)
                    .opacity(0.0)

                HStack(spacing: 0) {
                    if let home {
                        Image("C_\(home)")
                            .resizable()
                            .frame(width: circleWidth, height: circleWidth)
                    } else {
                        Circle()
                            .stroke(lineWidth: 2.0)
                            .frame(width: circleWidth, height: circleWidth)
                    }
                }
            }

            if alignment == .trailing {
                VStack(spacing: circleWidth + (teamSpace * 2) + 20 ) {
                    Rectangle()
                        .frame(width: circleWidth / 7, height: 1)

                    Rectangle()
                        .frame(width: circleWidth / 7, height: 1)
                }

                VStack {
                    Rectangle()
                        .frame(width: 1, height: circleWidth + (teamSpace * 2) + 20)
                }
            }
            
            if alignment == .leading {
                VStack(spacing: circleWidth + (teamSpace * 2) + 20 ) {
                    Rectangle()
                        .frame(width: circleWidth / 7, height: 1)
                        .opacity(toWinner ? 1.0 : 0.0)
                    
                    Rectangle()
                        .frame(width: circleWidth / 7, height: 1)
                        .opacity(bottomWinner ? 1.0 : 0.0)
                    
                }
            }
        }
    }
}

#Preview {
    PostNode(away: "LAD", home: "SD", alignment: .trailing, circleWidth: 60, teamSpace: 60, toWinner: true, bottomWinner: true)
}
