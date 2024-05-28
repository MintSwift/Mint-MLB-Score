import SwiftUI
import Kingfisher

struct PostSeasonSidebar: View {
    @EnvironmentObject var interactor: PostSeasonInteractor
    
    var body: some View {
        ScrollView(.horizontal) {
            PostScrollview()
        }
        .navigationTitle("Post-Season")
    }
}

