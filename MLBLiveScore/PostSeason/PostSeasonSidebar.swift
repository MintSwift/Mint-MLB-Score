import SwiftUI
import Kingfisher

struct PostSeasonSidebar: View {
    @EnvironmentObject var interactor: PostSeasonInteractor
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            PostScrollview()
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    Task {
                        await interactor.retrieve()
                    }
                }, label: {
                    Text("새로고침")
                })
            }
        }
        .navigationTitle("Post-Season")
        .navigationBarTitleDisplayMode(.inline)
    }
}

