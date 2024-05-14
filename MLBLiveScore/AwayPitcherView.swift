//import SwiftUI
//import Kingfisher
//import SwiftDate
//
//struct AwayPitcherView: View {
//    let game: Game
//    
//    
//    var body: some View {
//        if let winner = game.away.winner, game.state == .final {
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
//                if let save = game.away.save, save.isEmpty == false {
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
//            if let loser = game.away.loser, game.state == .final {
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
