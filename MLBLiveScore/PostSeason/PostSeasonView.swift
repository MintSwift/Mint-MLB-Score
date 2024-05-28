import SwiftUI

struct PostSeasonView: View {
    @StateObject var interactor = PostSeasonInteractor.create()
    
    var body: some View {
        NavigationSplitView {
            PostSeasonSidebar()
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


#Preview {
    PostSeasonView()
}
