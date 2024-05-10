import SwiftUI
import Kingfisher
import SwiftDate

struct ContentCell: View {
    let game: Game
    
    var body: some View {
        HStack {
            HStack {
                Spacer()
                VStack(alignment: .trailing) {
                    Text(game.away.locationName)
                    Text(game.away.clubName)
                }
                .font(.caption)
                .padding(.trailing, 5)
                
                KFImage(URL(string: "https://a.espncdn.com/i/teamlogos/mlb/500/\(game.away.symbol).png"))
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .center)
                    .scaledToFit()
                
                if game.away.score > game.home.score {
                    Text("\(game.away.score)")
                        .overlay(alignment: .top, content: {
                            Circle()
                                .foregroundStyle(.red)
                                .frame(width: 5, height: 5, alignment: .center)
                                .opacity(0.6)
                                .offset(y: -5)
                        })
                        .frame(width: 20)
                } else {
                    Text("\(game.away.score)")
                        .frame(width: 20)
                }
            }
            
            .containerRelativeFrame(.horizontal, count: 30, span: 12, spacing: 0)
            
            
            VStack {
                if let reason = game.reason {
                    Text(reason)
                        .font(.subheadline)
                } else {
                    if game.state == .final {
                        Text(game.state.rawValue)
                            .font(.footnote)
                    } else if game.state == .preview {
//                        Text("몇시?")
                        if let date = game.date {
                            VStack {
                                Text(date.toFormat("a", locale: Locales.korean))
                                    .font(.caption2)
                                Text(date.toFormat("hh:mm", locale: Locales.korean))
                            }
                            .font(.footnote)
                        }
                        
                    } else {
                        if game.isTopInning {
                            Text("\(game.currentInning)회 초")
                        } else {
                            Text("\(game.currentInning)회 말")
                        }
                        
                    }
                }
            }
            .containerRelativeFrame(.horizontal, count: 30, span: 4, spacing: 0)
            
            VStack {
                HStack {
                    if game.away.score < game.home.score {
                        Text("\(game.home.score)")
                            .overlay(alignment: .top, content: {
                                Circle()
                                    .foregroundStyle(.red)
                                    .frame(width: 5, height: 5, alignment: .center)
                                    .opacity(0.6)
                                    .offset(y: -5)
                            })
                            .frame(width: 20)
                    } else {
                        Text("\(game.home.score)")
                            .frame(width: 20)
                    }
                    
                    KFImage(URL(string: "https://a.espncdn.com/i/teamlogos/mlb/500/\(game.home.symbol.lowercased()).png"))
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                    
                    VStack(alignment: .leading) {
                        Text(game.home.locationName)
                        Text(game.home.clubName)
                    }
                    .font(.caption)
                    .padding(.leading, 5)
                    
                    Spacer()
                }
            }
            .containerRelativeFrame(.horizontal, count: 30, span: 12, spacing: 0)
        }
        
    }
}

#Preview {
    ContentView()
}
