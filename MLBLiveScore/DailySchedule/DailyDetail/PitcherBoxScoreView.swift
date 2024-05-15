import SwiftUI

struct PitcherBoxScoreView: View {
    var players: [MPlayer]
    let player: Player?
    
    init(players: [MPlayer], player: Player?) {
        self.players = players
        self.player = player
    }
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Pitcher")
                        .font(.caption2)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .containerRelativeFrame(.horizontal, count: 100, span: 30, spacing: 0, alignment: .leading)
                    
                    HStack {
                        HStack(spacing: 2) {
                            Text("IP")
                                .frame(width: 20, alignment: .center)
                            
                            Text("H")
                                .frame(width: 20, alignment: .center)
                            
                            Text("R")
                                .frame(width: 20, alignment: .center)
                            
                            Text("ER")
                                .frame(width: 20, alignment: .center)
                            
                            Text("BB")
                                .frame(width: 20, alignment: .center)
                            
                            Text("K")
                                .frame(width: 20, alignment: .center)
                            
                            Text("HR")
                                .frame(width: 25, alignment: .center)
                        }
                        .containerRelativeFrame(.horizontal, count: 100, span: 42, spacing: 0)
                        
                        Spacer()
                        
                        HStack {
                            Text("ERA")
                                .frame(width: 30, alignment: .center)
                        }
                        .containerRelativeFrame(.horizontal, count: 100, span: 20, spacing: 0)
                    }
                    .font(.caption)
                    
                }
                Divider()
            }
            
            VStack(spacing: 2) {
                ForEach(players) { batter in
                    
                    HStack {
                        ZStack {
                            if batter.battingOrder % 100 != 0 {
                                HStack {
                                    if batter.number == player?.number {
                                        Image(systemName: "arrowtriangle.right.fill")
                                            .resizable()
                                            .frame(width: 5, height: 10)
                                            .foregroundStyle(.blue)
                                    }
                                    
                                    Image(systemName: "arrow.turn.down.right")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 10, height: 10)
                                        .padding(.leading, 2)
                                    
                                    Text(batter.name ?? "")
                                        .font(.caption)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)
                                }
                                
                            } else {
                                HStack {
                                    if batter.number == player?.number {
                                        Image(systemName: "arrowtriangle.right.fill")
                                            .resizable()
                                            .frame(width: 5, height: 10)
                                            .foregroundStyle(.blue)
                                    }
                                    
                                    Text(batter.name ?? "")
                                        .font(.caption)
                                        .lineLimit(1)
                                        .minimumScaleFactor(0.8)
                                }
                            }
                        }
                        .containerRelativeFrame(.horizontal, count: 100, span: 30, spacing: 0, alignment: .leading)
                        
                        
                        
                        HStack {
                            HStack(spacing: 1) {
                                Text(batter.pitcherTodayRecord?.ip ?? "")
                                    .frame(width: 20, alignment: .center)
                                
                                Text(batter.pitcherTodayRecord?.h ?? "")
                                    .frame(width: 20, alignment: .center)
                                
                                Text(batter.pitcherTodayRecord?.r ?? "")
                                    .frame(width: 20, alignment: .center)
                                
                                Text(batter.pitcherTodayRecord?.er ?? "")
                                    .frame(width: 20, alignment: .center)
                                
                                Text(batter.pitcherTodayRecord?.bb ?? "")
                                    .frame(width: 20, alignment: .center)
                                
                                Text(batter.pitcherTodayRecord?.k ?? "")
                                    .frame(width: 20, alignment: .center)
                                
                                Text(batter.pitcherTodayRecord?.hr ?? "")
                                    .frame(width: 25, alignment: .center)
                                
                            }
                            .containerRelativeFrame(.horizontal, count: 100, span: 42, spacing: 0)
                            
                            Spacer()
                            
                            HStack {
                                Text(batter.pitcherSeasonRecord?.era ?? ".000")
                                    .frame(width: 30, alignment: .center)
                            }
                            .containerRelativeFrame(.horizontal, count: 100, span: 20, spacing: 0)
                        }
                        .font(.caption)
                    }
                    .background {
                        if batter.number == player?.number {
                            Color.gray.opacity(0.5)
                                .padding(-3)
                        }
                        
                    }
                    
                    Divider()
                }
            }
        }
    }
}
