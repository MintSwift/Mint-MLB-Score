import SwiftUI
import Kingfisher
import SwiftDate

struct DailyDetailView: View {
    @EnvironmentObject var interactor: ScheduleInteractor
//    @State var liveScore: LiveScore? = nil
    let timer = Timer.publish(every: 30, on: .main, in: .common).autoconnect()
    let gamePk: String
    init(gamePk: String) {
        print("DailyDetailView", gamePk)
        self.gamePk = gamePk
    }
    
    var body: some View {
        VStack {
            ScoreboardView($interactor.liveScore)
                .padding(.top, 10)
            
            ScrollView {
                
                HStack(alignment: .top, spacing: 0) {
                    DiamondView(runner: interactor.liveScore?.runner)
                        .containerRelativeFrame(.horizontal, count: 100, span: 65, spacing: 0, alignment: .center)
                    
                    Spacer()
                    
                    VStack {
                        OutCountView(outCount: interactor.liveScore?.outCount)
                        
                        Spacer()
                        
                        if let player = interactor.liveScore?.onDeckPlayer,
                           let number = player.number,
                           let name = player.name {
                            HStack {
                                KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(number)/spots/90"))
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                                
                                Text(name)
                                    .font(.caption)
                                    .foregroundStyle(.white)
                                    .padding(.horizontal, 5)
                                    .padding(.vertical, 2)
                                    .background {
                                        RoundedRectangle(cornerRadius: 5)
                                            .foregroundStyle(.blue)
                                    }
                            }
                            .offset(x: -40)
                        }
                    }
                    .containerRelativeFrame(.horizontal, count: 100, span: 30, spacing: 0, alignment: .top)
                    
                }
                .padding(.top, 30)
                
                
                
                Spacer()
            }
            
        }
        .task {
            await interactor.liveGame(id: gamePk)
        }
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    Task {
                        await interactor.liveGame(id: gamePk)
                    }
                } label: {
                    Image(systemName: "arrow.circlepath")
                }
                
            }
        }
    }
}

