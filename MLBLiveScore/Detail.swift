import SwiftUI
import Kingfisher
import SwiftDate

struct Detail: View {
    @EnvironmentObject var interactor: Interactor
    
    let game: Game
    
    
    var body: some View {
        VStack {
            Text(verbatim: "\(game.gameId)")
            ContentCell(game: game)
            
            VStack(alignment: .leading) {
                HStack {
                    Text("B")
                        .frame(width: 15)
                    
                    ForEach(0...2, id: \.self) { index in
                        if (index) < Int(interactor.liveScore?.outCount.balls ?? "0") ?? 0 {
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
                        if (index) < Int(interactor.liveScore?.outCount.strikes ?? "0") ?? 0 {
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
                        if (index) < Int(interactor.liveScore?.outCount.outs ?? "0") ?? 0 {
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
        .onAppear {
            Task {
                await interactor.detail(id: game.gameId)
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await interactor.schedule()
                        await interactor.detail(id: game.gameId)
                    }
                } label: {
                    Image(systemName: "arrow.circlepath")
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
