import SwiftUI
import MLBPresenter

struct BatterLineUp: View {
    var batters: [BatterStatsPresenter]
    var offense: OffensePresenter?
    var defense: DefensePresenter?
    
    init(_ batters: [BatterStatsPresenter],
         offense: OffensePresenter?,
         defense: DefensePresenter?
    ) {
        self.batters = batters
        self.offense = offense
        self.defense = defense
    }
    var body: some View {
        VStack {
            header
            
            VStack(spacing: 2) {
                ForEach(batters) { batter in
                    if batter.battingOrder / 100 != 0 {
                        HStack(spacing: 0) {
                            ZStack {
                                if batter.battingOrder % 100 != 0 {
                                    HStack(spacing: 0) {
                                        if batter.number == offense?.batterNumber {
                                            Image(systemName: "arrowtriangle.right.fill")
                                                .resizable()
                                                .frame(width: 5, height: 10)
                                                .foregroundStyle(.blue)
                                                .padding(.horizontal, 5)
                                        }
                                        
                                        Image(systemName: "arrow.turn.down.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 10, height: 10)
                                            .padding(.horizontal, 3)
                                        
                                        Text(batter.name)
                                            .font(.caption)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.8)
                                    }
                                    
                                } else {
                                    HStack(spacing: 0) {
                                        if batter.number == offense?.batterNumber {
                                            Image(systemName: "arrowtriangle.right.fill")
                                                .resizable()
                                                .frame(width: 5, height: 10)
                                                .foregroundStyle(.blue)
                                                .padding(.horizontal, 5)
                                        }
                                        
                                        Text(batter.name)
                                            .font(.caption)
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.8)
                                    }
                                }
                            }
                            .containerRelativeFrame(.horizontal, count: 100, span: 35, spacing: 0, alignment: .leading)
                            
                            Spacer(minLength: 1)
                            
                            HStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Text(batter.atBats)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                                    
                                    Text(batter.runs)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                                    
                                    Text(batter.hits)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                                    
                                    Text(batter.homeRuns)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                                    
                                    Text(batter.rbi)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 7, spacing: 0)
                                    
                                    Text(batter.baseOnBalls)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                                    
                                    Text(batter.strikeOuts)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                                    
                                    
                                    Text(batter.leftOnBase)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 7, spacing: 0)
                                    
                                }
                                .containerRelativeFrame(.horizontal, count: 100, span: 44, spacing: 0)
                                

                                
                                HStack(spacing: 0) {
                                    Text(batter.avg)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 9, spacing: 0)
                                    
                                    Text(batter.ops)
                                        .containerRelativeFrame(.horizontal, count: 100, span: 9, spacing: 0)
                                }
                                .containerRelativeFrame(.horizontal, count: 100, span: 19, spacing: 0)
                            }
                            .font(.caption)
                        }
                        .background {
                            if batter.number == offense?.batterNumber {
                                Color.gray.opacity(0.5)
                                .padding(-3)
                            }
                        }
                        
                        Divider()
                    }
                }
            }
        }
        .padding(.horizontal, 8)
    }
    
    var header: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Batter")
                    .font(.caption2)
                    .lineLimit(1)
                    .minimumScaleFactor(0.8)
                    .containerRelativeFrame(.horizontal, count: 100, span: 35, spacing: 0, alignment: .leading)
                    .background(.yellow.opacity(0.4))
                
                Spacer(minLength: 1)
                
                HStack(spacing: 0) {
                    HStack(spacing: 0) {
                        Text("AB")
                            .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                         
                        Text("R")
                            .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                         
                        Text("H")
                            .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                        
                        Text("HR")
                            .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                         
                        Text("RBI")
                            .containerRelativeFrame(.horizontal, count: 100, span: 7, spacing: 0)
                  
                        Text("BB")
                            .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)
                            
                        Text("K")
                            .containerRelativeFrame(.horizontal, count: 100, span: 5, spacing: 0)

                        Text("LOB")
                            .containerRelativeFrame(.horizontal, count: 100, span: 7, spacing: 0)
                            
                    }
                    .containerRelativeFrame(.horizontal, count: 100, span: 44, spacing: 0)
                    .background(.blue.opacity(0.4))
                    
                    
                    
                    HStack(spacing: 0) {
                        Text("AVG")
                            .containerRelativeFrame(.horizontal, count: 100, span: 9, spacing: 0)
                            .background(.yellow.opacity(0.4))
                        Text("OPS")
                            .containerRelativeFrame(.horizontal, count: 100, span: 9, spacing: 0)
                            .background(.yellow.opacity(0.4))
                    }
                    .containerRelativeFrame(.horizontal, count: 100, span: 19, spacing: 0)
                    .background(.blue.opacity(0.4))
                }
                .font(.caption)

            }
            Divider()
        }
    }
}
