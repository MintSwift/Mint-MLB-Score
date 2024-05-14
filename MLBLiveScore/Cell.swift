//import SwiftUI
//import Kingfisher
//import SwiftDate
//
//struct ContentCell: View {
//    @Binding var game: Game?
//    
//    init(game: Binding<Game?>) {
//        _game = game
//    }
//    
//    var body: some View {
//        HStack {
//            VStack(alignment: .trailing) {
//                HStack {
//                    if let game {
//                        ClubView(stadium: .away, team: game.away)
//                        
//                        ScoreView(stadium: .away, game: game)
//                    }
//                }
//                
//                .containerRelativeFrame(.horizontal, count: 30, span: 12, spacing: 0)
//                
//                if let game {
//                    AwayPitcherView(game: game)
//                }
//            }
//            
//            VStack {
//                if let reason = game?.reason {
//                    Text(reason)
//                        .font(.subheadline)
//                } else {
//                    if let game {
//                        if game.state == .final {
//                            Text(game.state.rawValue)
//                                .font(.footnote)
//                        } else if game.state == .preview {
//                            if let date = game.date {
//                                VStack {
//                                    Text(date.toFormat("a", locale: Locales.korean))
//                                        .font(.caption2)
//                                    Text(date.toFormat("hh:mm", locale: Locales.korean))
//                                }
//                                .font(.footnote)
//                            }
//                            
//                        } else {
//                            if game.isTopInning {
//                                HStack {
//                                    Text("\(game.currentInning)")
//                                    Image(systemName: "arrowtriangle.up.fill")
//                                        .resizable()
//                                        .foregroundStyle(.blue)
//                                        .frame(width: 10, height: 10, alignment: .center)
//                                }
//                            } else {
//                                HStack {
//                                    Text("\(game.currentInning)")
//                                    Image(systemName: "arrowtriangle.down.fill")
//                                        .resizable()
//                                        .foregroundStyle(.yellow)
//                                        .frame(width: 10, height: 10, alignment: .center)
//                                }
//                            }
//                            
//                        }
//                    }
//                }
//            }
//            .containerRelativeFrame(.horizontal, count: 30, span: 4, spacing: 0)
//            
//            VStack {
//                HStack {
//                    if let game {
//                        ScoreView(stadium: .home, game: game)
//                        
//                        ClubView(stadium: .home, team: game.home)
//                    }
//                }
//                
//                if let game {
//                    HomePitcherView(game: game)
//                }
//            }
//            .containerRelativeFrame(.horizontal, count: 30, span: 12, spacing: 0)
//        }
//        
//    }
//}
//
//#Preview {
//    ContentView()
//}
