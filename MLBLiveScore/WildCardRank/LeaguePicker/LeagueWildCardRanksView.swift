import SwiftUI
import Kingfisher
import MLBPresenter

struct LeagueWildCardRanksView: View {
    var ranks: [DivisionPresenter] = []
    
    var body: some View {
        ForEach(ranks) { division in
            Section {
                ForEach(division.leaders) { leaders in
                    HStack(spacing: 0) {
                        HStack {
                            Image("C_\(leaders.team.abbreviation)")
                                .resizable()
                                .frame(width: 20, height: 20, alignment: .center)
                            
                            
                            Text(leaders.teamNameDivision)
                        }
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .containerRelativeFrame(.horizontal, count: 100, span: 55, spacing: 0)
                        
                        Text(leaders.wins)
                            .font(.footnote)
                            .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                        Text(leaders.losses)
                            .font(.footnote)
                            .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                        Text(leaders.winningPercentage)
                            .font(.footnote)
                            .containerRelativeFrame(.horizontal, count: 100, span: 10, spacing: 0)
                        
                        Text(leaders.wildCardGamesBack)
                            .font(.footnote)
                            .containerRelativeFrame(.horizontal, count: 100, span: 15, spacing: 0)
                    }
                    .padding(.horizontal, 10)
                }
            } header: {
                HStack(spacing: 0) {
                    Text(division.title)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(.secondary)
                        .containerRelativeFrame(.horizontal, count: 100, span: 55, spacing: 0)
                    
                    Text("W")
                        .foregroundStyle(.secondary)
                        .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                    Text("L")
                        .foregroundStyle(.secondary)
                        .containerRelativeFrame(.horizontal, count: 100, span: 8, spacing: 0)
                    Text("PCT")
                        .foregroundStyle(.secondary)
                        .containerRelativeFrame(.horizontal, count: 100, span: 10, spacing: 0)
                    
                    Text("WCGB")
                        .foregroundStyle(.secondary)
                        .containerRelativeFrame(.horizontal, count: 100, span: 15, spacing: 0)
                }
                .padding(.horizontal, 10)
            }
        }
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
    }
}
