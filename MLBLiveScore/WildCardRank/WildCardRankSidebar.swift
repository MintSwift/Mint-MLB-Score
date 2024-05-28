import SwiftUI
import Kingfisher


struct WildCardRankSidebar: View {
    @EnvironmentObject var interactor: WildCardRankInteractor
    
    var body: some View {
        VStack {
            Picker("", selection: $interactor.pickerSelection) {
                ForEach(interactor.pickers, id: \.self) { picker in
                    Text(picker == 0 ? "American League" : "National League")
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 10)
            
            List {
                LeagueWildCardRanksView(ranks: interactor.alWildCardRank)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .listStyle(.plain)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                HStack {
                    Image("MLB_Logo")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 20, alignment: .center)
                }
            }
            
            ToolbarItem(placement: .principal) {
                HStack {
                    Text("Wild Card Rank")
                }
            }
        }
        .refreshable {
            await interactor.retrieve()
        }
    }
}
