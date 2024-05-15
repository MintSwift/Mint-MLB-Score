import SwiftUI

struct BoxScoreView: View {
    var batters: [MPlayer]
    let player: Player?

    init(batters: [MPlayer], player: Player?) {
        self.batters = batters
        self.player = player
    }
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Text("Batter")
                        .font(.caption2)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .containerRelativeFrame(.horizontal, count: 100, span: 30, spacing: 0, alignment: .leading)

                    HStack {
                        HStack(spacing: 2) {
                            Text("AB")
                                .frame(width: 20)
                             
                            Text("R")
                                .frame(width: 20)
                             
                            Text("H")
                                .frame(width: 20)
                             
                            Text("RBI")
                                .frame(width: 20)
                      
                            Text("BB")
                                .frame(width: 20)
                                
                            Text("K")
                                .frame(width: 20)

                            Text("LOB")
                                .frame(width: 25)
                        }
                        .containerRelativeFrame(.horizontal, count: 100, span: 42, spacing: 0)

                        Spacer()

                        HStack {
                            Text("AVG")
                                .frame(width: 30)
                            Text("OPS")
                                .frame(width: 30)
                        }
                        .containerRelativeFrame(.horizontal, count: 100, span: 20, spacing: 0)
                    }
                    .font(.caption)

                }
                Divider()
            }
            VStack(spacing: 2) {
                ForEach(batters) { batter in
                    if batter.battingOrder / 100 != 0 {
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
                                    Text(batter.todayRecord?.ab ?? "")
                                        .frame(width: 20)
                                    
                                    Text(batter.todayRecord?.r ?? "")
                                        .frame(width: 20)
                                    
                                    Text(batter.todayRecord?.h ?? "")
                                        .frame(width: 20)
                                    
                                    Text(batter.todayRecord?.rbi ?? "")
                                        .frame(width: 20)
                                    
                                    Text(batter.todayRecord?.bb ?? "")
                                        .frame(width: 20)
                                    
                                    Text(batter.todayRecord?.k ?? "")
                                        .frame(width: 20)
                                    
                                    
                                    Text(batter.todayRecord?.lob ?? "")
                                        .frame(width: 25)
                                    
                                }
                                .containerRelativeFrame(.horizontal, count: 100, span: 42, spacing: 0)
                                
                                Spacer()
                                
                                HStack {
                                    Text(batter.seasonRecord?.avg ?? ".000")
                                        .frame(width: 30)
                                    Text(batter.seasonRecord?.ops.prefix(4) ?? ".000")
                                        .frame(width: 30)
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
}
