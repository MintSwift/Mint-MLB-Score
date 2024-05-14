//import SwiftUI
//
//struct BoxScoreView: View {
//    @Binding var boxscore: BoxScore?
//    
//    init(boxscore: Binding<BoxScore?>) {
//        _boxscore = boxscore
//    }
//    
//    
//    var body: some View {
//        
//        VStack {
//            VStack {
//                HStack {
//                    Text("No. Name")
//                        .font(.caption2)
//                        .lineLimit(1)
//                        .minimumScaleFactor(0.8)
//                        .containerRelativeFrame(.horizontal, count: 100, span: 30, spacing: 0, alignment: .leading)
//                    
//                    HStack {
//                        HStack(spacing: 1) {
//                            Text("AB")
//                                .frame(width: 20)
//                                .background {
//                                    Color.red
//                                }
//                            Text("R")
//                                .frame(width: 20)
//                                .background {
//                                    Color.red
//                                }
//                            Text("H")
//                                .frame(width: 20)
//                                .background {
//                                    Color.red
//                                }
//                            Text("RBI")
//                                .frame(width: 20)
//                                .background {
//                                    Color.red
//                                }
//                            Text("BB")
//                                .frame(width: 20)
//                                .background {
//                                    Color.red
//                                }
//                            Text("K")
//                                .frame(width: 20)
//                                .background {
//                                    Color.red
//                                }
//                            Text("LOB")
//                                .frame(width: 25)
//                                .background {
//                                    Color.red
//                                }
//                        }
//                        .containerRelativeFrame(.horizontal, count: 100, span: 42, spacing: 0)
//                        
//                        Spacer()
//                        
//                        HStack {
//                            Text("AVG")
//                                .frame(width: 30)
//                            Text("OPS")
//                                .frame(width: 30)
//                        }
//                        .containerRelativeFrame(.horizontal, count: 100, span: 20, spacing: 0)
//                    }
//                    .font(.caption)
//                    
//                }
//                Divider()
//            }
//            
//            ForEach(boxscore?.awayBatters ?? []) { batter in
//                if batter.battingOrder / 100 != 0 {
//                    VStack {
//                        HStack {
//                            if batter.battingOrder % 100 != 0 {
//                                HStack {
//                                    Image(systemName: "arrow.turn.down.right")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 10, height: 10)
//                                    
//                                    Text(batter.name)
//                                        .font(.caption2)
//                                        .lineLimit(1)
//                                        .minimumScaleFactor(0.8)
//                                        
//                                }
//                                .containerRelativeFrame(.horizontal, count: 100, span: 30, spacing: 0, alignment: .leading)
//                            } else {
//                                Text("\(batter.battingOrder / 100)  " + batter.name)
//                                    .font(.caption2)
//                                    .lineLimit(1)
//                                    .minimumScaleFactor(0.8)
//                                    .containerRelativeFrame(.horizontal, count: 100, span: 30, spacing: 0, alignment: .leading)
//                                
//                            }
//                            
//                            
//                            
//                            HStack {
//                                HStack(spacing: 1) {
//                                    Text(batter.ab)
//                                        .frame(width: 20)
//                              
//                                    Text(batter.r)
//                                        .frame(width: 20)
//                               
//                                    Text(batter.h)
//                                        .frame(width: 20)
//                                     
//                                    Text(batter.rbi)
//                                        .frame(width: 20)
//                                     
//                                    Text(batter.bb)
//                                        .frame(width: 20)
//                                  
//                                    Text(batter.k)
//                                        .frame(width: 20)
//                                        
//                                     
//                                    Text(batter.lob)
//                                        .frame(width: 25)
//                                        
//                                }
//                                .containerRelativeFrame(.horizontal, count: 100, span: 42, spacing: 0)
//                                
//                                Spacer()
//                                
//                                HStack {
//                                    Text(batter.avg)
//                                        .frame(width: 30)
//                                    Text(batter.ops.prefix(4))
//                                        .frame(width: 30)
//                                }
//                                .containerRelativeFrame(.horizontal, count: 100, span: 20, spacing: 0)
//                            }
//                            .font(.caption)
//                            
//                        }
//                        Divider()
//                    }
//                    
//                }
//                
//                
//            }
//        }
//    }
//}
