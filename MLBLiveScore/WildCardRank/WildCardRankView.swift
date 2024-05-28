import SwiftUI

struct WildCardRankView: View {
    @StateObject var interactor = WildCardRankInteractor.create()
    
    var body: some View {
        NavigationSplitView {
            WildCardRankSidebar()
        } detail: {
            
        }
        .environmentObject(interactor)
        .onAppear {
            Task {
                await interactor.retrieve()
            }
        }
    }
}
