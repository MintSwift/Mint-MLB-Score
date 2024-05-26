import SwiftUI
import MLBPresenter
import Kingfisher

struct LineScoreBoardView: View {
    var linescore: LinescorePresenter
    var awayTeamName: String
    var homwTeamName: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 5) {
                    Text(" ")
                        .font(.callout)
                    Image(awayTeamName)
                        .resizable()
                        .frame(width: 20, height: 20)
                
                    Image(homwTeamName)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                ForEach(linescore.innings) { inning in
                    VStack(spacing: 5) {
                        Text(String( inning.num ))
                            .font(.callout)
                            .foregroundStyle(.secondary)
                        
                        Text(inning.away.runs)
                            .font(.body)
                            .padding(.horizontal, 3)
                            .background {
                                if linescore.currentInningOrdinal == inning.ordinalNum && (linescore.inningState == .top) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .frame(width: 20)
                                        .foregroundStyle(.gray)
                                        .opacity(0.5)
                                }
                            }
                        Text(inning.home.runs)
                            .font(.body)
                            .padding(.horizontal, 3)
                            .background {
                                if linescore.currentInningOrdinal == inning.ordinalNum && (linescore.inningState == .bottom || linescore.inningState == .middle) {
                                    RoundedRectangle(cornerRadius: 3)
                                        .frame(width: 20)
                                        .foregroundStyle(.gray)
                                        .opacity(0.5)
                                }
                            }
                    }
                    .frame(width: 20)
                }
                
                HStack {
                    VStack(alignment: .center, spacing: 5) {
                        Text("R")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        Text(linescore.teams?.away.runs ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        
                        Text(linescore.teams?.home.runs ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                    }
                    .frame(width: 20)
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("H")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        Text(linescore.teams?.away.hits ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        
                        Text(linescore.teams?.home.hits ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                    }
                    .frame(width: 20)
                    
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("E")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        Text(linescore.teams?.away.errors ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        Text(linescore.teams?.home.errors ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                    }
                    .frame(width: 20)
                    
                }
            }
            .padding(.top, 5)
        }
    }
}

#Preview {
    SeasonScheduleView()
}
