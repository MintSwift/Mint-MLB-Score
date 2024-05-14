//import SwiftUI
//import Kingfisher
//import SwiftDate
//
//struct PitcherView: View {
//    let stadium: Stadium
//    let gameData: GameData
//    
//    var body: some View {
//        VStack(alignment: stadium == .away ? .trailing : .leading) {
//            if gameData.state == .live || gameData.state == .preview {
//                if let pitcher = gameData.away.firstPitcher, stadium == .away {
//                    HStack {
//                        Text(pitcher.name)
//                            .font(.footnote)
//                            .foregroundStyle(.secondary)
//                        
//                        Image(systemName: "p.square.fill")
//                            .resizable()
//                            .foregroundStyle(.secondary)
//                            .frame(width: 15, height: 15, alignment: .center)
//                    }
//                }
//                
//                if let pitcher = gameData.home.firstPitcher, stadium == .home {
//                    HStack {
//                        Image(systemName: "p.square.fill")
//                            .resizable()
//                            .foregroundStyle(.secondary)
//                            .frame(width: 15, height: 15, alignment: .center)
//                        
//                        Text(pitcher.name)
//                            .font(.footnote)
//                            .foregroundStyle(.secondary)
//                    }
//                }
//            } else if gameData.state == .final {
//                if stadium == .away && gameData.away.isWinner == true {
//                    // Away팀 승리했고 승리투수
//                    VStack(alignment: .trailing, spacing: 2) {
//                        if let winnerPitcher = gameData.winnerPitcher {
//                            HStack {
//                                Text(winnerPitcher.name)
//                                    .font(.caption2)
//                                
//                                Image(systemName: "w.square.fill")
//                                    .resizable()
//                                    .foregroundStyle(.red)
//                                    .frame(width: 12, height: 12, alignment: .center)
//                            }
//                        }
//                        
//                        if let savePitcher = gameData.savePitcher {
//                            HStack {
//                                Text(savePitcher.name)
//                                    .font(.caption2)
//                                    .foregroundStyle(.secondary)
//                                
//                                Image(systemName: "s.square.fill")
//                                    .resizable()
//                                    .foregroundStyle(.blue)
//                                    .frame(width: 12, height: 12, alignment: .center)
//                            }
//                        }
//                    }
//                }
//                
//                if stadium == .away && gameData.home.isWinner == true {
//                    // Away팀 패배했고, 패전투수
//                    if let loserPitcher = gameData.loserPitcher {
//                        HStack {
//                            Text(loserPitcher.name)
//                                .font(.caption2)
//                                .foregroundStyle(.secondary)
//                            
//                            Image(systemName: "l.square.fill")
//                                .resizable()
//                                .foregroundStyle(.gray)
//                                .frame(width: 12, height: 12, alignment: .center)
//                        }
//                    }
//                }
//                
//                if stadium == .home && gameData.home.isWinner == true {
//                    // Home팀 승리했고, 승리투스
//                    VStack(alignment: .leading, spacing: 2) {
//                        if let winnerPitcher = gameData.winnerPitcher {
//                            HStack {
//                                Image(systemName: "w.square.fill")
//                                    .resizable()
//                                    .foregroundStyle(.red)
//                                    .frame(width: 12, height: 12, alignment: .center)
//                                Text(winnerPitcher.name)
//                                    .font(.caption2)
//                            }
//                        }
//                        
//                        if let savePitcher = gameData.savePitcher {
//                            HStack {
//                                Image(systemName: "s.square.fill")
//                                    .resizable()
//                                    .foregroundStyle(.blue)
//                                    .frame(width: 12, height: 12, alignment: .center)
//                                Text(savePitcher.name)
//                                    .font(.caption2)
//                                    .foregroundStyle(.secondary)
//                            }
//                        }
//                    }
//                }
//                
//                if stadium == .home && gameData.away.isWinner == true {
//                    // Home팀 패배했고, 패전투스
//                    if let loserPitcher = gameData.loserPitcher {
//                        HStack {
//                            Image(systemName: "l.square.fill")
//                                .resizable()
//                                .foregroundStyle(.gray)
//                                .frame(width: 12, height: 12, alignment: .center)
//                            Text(loserPitcher.name)
//                                .font(.caption2)
//                                .foregroundStyle(.secondary)
//                        }
//                    }
//                }
//            }
//        }
//    }
//}
