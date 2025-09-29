import SwiftUI

struct PostScrollview: View {
    @EnvironmentObject var interactor: PostSeasonInteractor
    
    var body: some View {
        if interactor.americanDivisionLeaders.isEmpty == false {
            HStack(spacing: 0) {
                VStack(spacing: 80) {
                    PostNode(away: interactor.americanWildCardLeaders[2].team.abbreviation, home: interactor.americanDivisionLeaders[2].team.abbreviation, alignment: .trailing, circleWidth: 80, teamSpace: 6)
                    PostNode(away: interactor.americanWildCardLeaders[1].team.abbreviation, home: interactor.americanWildCardLeaders[0].team.abbreviation, alignment: .trailing, circleWidth: 80, teamSpace: 6)
                }
                
                VStack(spacing: 80) {
                    PostNode(away: nil, home: interactor.americanDivisionLeaders[1].team.abbreviation, alignment: .trailing, circleWidth: 80, teamSpace: 6, toWinner: true)
                    
                    PostNode(away: nil, home: interactor.americanDivisionLeaders[0].team.abbreviation, alignment: .trailing, circleWidth: 80, teamSpace: 6, toWinner: true)
                    
                }
                .offset(y: 55)
                
                VStack {
                    PostNode(away: nil, home: nil, alignment: .trailing, circleWidth: 80, teamSpace: 80, toWinner: true, bottomWinner: true)
                }
                .offset(y: 55)
                
                VStack {
                    HStack {
                        HStack(spacing: 0) {
                            Rectangle()
                                .frame(width: 10, height: 1)
                            Circle()
                                .stroke(lineWidth: 2.0)
                                .frame(width: 80, height: 80)
                        }
                        
                        HStack(spacing: 0) {
                            Circle()
                                .stroke(lineWidth: 2.0)
                                .frame(width: 80, height: 80)
                            
                            Rectangle()
                                .frame(width: 10, height: 1)
                        }
                    }
                    
                    //                Circle()
                    //                    .frame(width: 100, height: 100)
                }
                .offset(y: 60)
                
                VStack {
                    PostNode(away: nil, home: nil, alignment: .leading, circleWidth: 80, teamSpace: 80, toWinner: true, bottomWinner: true)
                }
                .offset(y: 55)
                
                VStack(spacing: 80) {
                    PostNode(away: nil, home: interactor.nationalDivisionLeaders[1].team.abbreviation, alignment: .leading, circleWidth: 80, teamSpace: 6, toWinner: true)
                    PostNode(away: nil, home: interactor.nationalDivisionLeaders[0].team.abbreviation, alignment: .leading, circleWidth: 80, teamSpace: 6, toWinner: true)
                }
                .offset(y: 55)
                
                VStack(spacing: 80) {
                    PostNode(away: interactor.nationalWildCardLeaders[2].team.abbreviation, home: interactor.nationalDivisionLeaders[2].team.abbreviation, alignment: .leading, circleWidth: 80, teamSpace: 6)
                    PostNode(away: interactor.nationalWildCardLeaders[1].team.abbreviation, home: interactor.nationalWildCardLeaders[0].team.abbreviation, alignment: .leading, circleWidth: 80, teamSpace: 6)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 20)
            .offset(y: -55)
        }
    }
}

#Preview {
    PostSeasonView()
}
