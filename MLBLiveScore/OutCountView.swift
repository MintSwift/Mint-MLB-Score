import SwiftUI
import Kingfisher
import SwiftDate

struct OutCountView: View {
    let outCount: OutCount
    
    init(outCount: OutCount?) {
        let balls = Int( outCount?.balls ?? "0" ) ?? 0
        let strikes = Int( outCount?.strikes ?? "0" ) ?? 0
        let outs = Int( outCount?.outs ?? "0" ) ?? 0
        
        self.outCount = OutCount(balls: balls, strikes: strikes, outs: outs)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("B")
                    .frame(width: 15)
                
                ForEach(0...2, id: \.self) { index in
                    if (index) < Int(outCount.balls) ?? 0 {
                        Circle()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundStyle(.green)
                    } else {
                        Circle()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundStyle(.gray)
                    }
                }
            }
            
            HStack {
                Text("S")
                    .frame(width: 15)
                ForEach(0...1, id: \.self) { index in
                    if (index) < Int(outCount.strikes) ?? 0 {
                        Circle()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundStyle(.orange)
                    } else {
                        Circle()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundStyle(.gray)
                    }
                    
                }
            }
            
            HStack {
                Text("O")
                    .frame(width: 15)
                
                ForEach(0...1, id: \.self) { index in
                    if (index) < Int(outCount.outs) ?? 0 {
                        Circle()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundStyle(.red)

                    } else {
                        Circle()
                            .frame(width: 20, height: 20, alignment: .center)
                            .foregroundStyle(.gray)

                    }
                    
                }
            }
            
        }
    }
}

#Preview {
    ContentView()
}
