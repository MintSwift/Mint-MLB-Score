//import SwiftUI
//import Kingfisher
//import SwiftDate
//
//struct HomePitcherView: View {
//    let game: Game
//    
//    var body: some View {
//        if let winner = game.home.winner, game.state == .final {
//            HStack(alignment: .bottom) {
//                HStack {
//                    Image(systemName: "w.square.fill")
//                        .resizable()
//                        .foregroundStyle(.red)
//                        .frame(width: 12, height: 12, alignment: .center)
//                    Text(winner)
//                        .font(.caption2)
//                }
//                
//                if let save = game.home.save, save.isEmpty == false {
//                    HStack {
//                        Image(systemName: "s.square.fill")
//                            .resizable()
//                            .foregroundStyle(.blue)
//                            .frame(width: 12, height: 12, alignment: .center)
//                        Text(save)
//                            .font(.caption2)
//                    }
//                }
//            }
//        } else {
//            if let loser = game.home.loser, game.state == .final {
//                HStack {
//                    Image(systemName: "l.square.fill")
//                        .resizable()
//                        .foregroundStyle(.gray)
//                        .frame(width: 12, height: 12, alignment: .center)
//                    Text(loser)
//                        .font(.caption2)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    ContentView()
//}
