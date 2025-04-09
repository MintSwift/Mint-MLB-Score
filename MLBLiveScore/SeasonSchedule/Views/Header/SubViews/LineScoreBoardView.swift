import SwiftUI
import MLBPresenter
import Kingfisher

struct LineScoreBoardView: View {
    var linescore: LinescorePresenter
    var awayTeamName: String
    var homwTeamName: String
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(" ")
                        .font(.callout)
                    HStack {
                        Image(awayTeamName)
                            .resizable()
                            .scaledToFit()

                        Text(awayTeamName)
                            .font(.footnote)
                    }
                    .frame(height: 20)
                    
                    HStack {
                        Image(homwTeamName)
                            .resizable()
                            .scaledToFit()
                        Text(homwTeamName)
                            .font(.footnote)
                    }
                    .frame(height: 20)
                }
                .containerRelativeFrame(.horizontal, count: 100, span: 20, spacing: 0, alignment: .center)
                
                HStack(spacing: 9) {
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
                        //                    .frame(width: 25)
                    }
                }
//                .containerRelativeFrame(.horizontal, count: 100, span: 65, spacing: 0)
                
                
                HStack {
                    VStack(alignment: .center, spacing: 5) {
                        Text("R")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        Text(linescore.teams?.away.runs ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.body)
                        
                        
                        Text(linescore.teams?.home.runs ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.body)
                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("H")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        Text(linescore.teams?.away.hits ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.body)
                        
                        
                        Text(linescore.teams?.home.hits ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.body)
                    }
                    
                    VStack(alignment: .center, spacing: 5) {
                        Text("E")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.callout)
                        
                        Text(linescore.teams?.away.errors ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.body)
                        
                        Text(linescore.teams?.home.errors ?? "")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .font(.body)
                    }
                    
                }
                .containerRelativeFrame(.horizontal, count: 100, span: 20, spacing: 0)
                .padding(.horizontal, 5)
            }
            .padding(.top, 5)
        }
    }
}

#Preview {
    SeasonScheduleView()
}
