import SwiftUI
import Kingfisher
import SwiftDate
struct SeasonRecord: Identifiable, Hashable, Equatable {
    var id: String

        let avg: String
        let ops: String
    
    init(avg: String,
         ops: String) {
        self.id = UUID().uuidString
        self.avg = avg
        self.ops = ops
    }
}

struct TodayRecord: Identifiable, Hashable, Equatable {
    var id: String

    let ab: String
    let r: String
    let h: String

    let rbi: String
    let bb: String
    let k: String
    let lob: String
    
    init(name: String, 
         number: String,
         battingOrder: Int,
         ab: String,
         r: String,
         h: String,
         rbi: String,
         bb: String,
         k: String,
         lob: String) {
        self.id = UUID().uuidString
        self.ab = ab
        self.r = r
        self.h = h
        self.rbi = rbi
        self.bb = bb
        self.k = k
        self.lob = lob
    }
}

struct Player: Identifiable, Hashable, Equatable {
    var id: String
    
    let name: String?
    let number: String?
    
    let seasonRecord: SeasonRecord?
    let todayRecord: TodayRecord?
    
    init(name: String?, number: String?, todayRecord: TodayRecord? = nil, seasonRecord: SeasonRecord? = nil) {
        self.id = UUID().uuidString
        self.name = name
        self.number = number
        self.todayRecord = todayRecord
        self.seasonRecord = seasonRecord
    }
}

struct Runner: Identifiable, Hashable, Equatable {
    var id: String
    
    let batter: Player
    let first: Player
    let second: Player
    let third: Player
    
    init(batter: Player, first: Player, second: Player, third: Player) {
        self.id = UUID().uuidString
        self.batter = batter
        self.first = first
        self.second = second
        self.third = third
    }
    
    static var review: Runner {
        let batter = Player(name: "Adley Rutschman", number: "668939")
        let first = Player(name: "Corbin Burnes", number: "669203")
        let second = Player(name: "Keegan Akin", number: "669211")
        let third = Player(name: "Jordan Westburg", number: "672335")
        
        
        let r = Runner(batter: batter, first: first, second: second, third: third)
        return r
    }
}



struct DiamondView: View {
    let runner: Runner?
    
    init(runner: Runner?) {
        self.runner = runner
    }

    var body: some View {
        ZStack {
            Image(systemName: "diamond.fill")
                .resizable()
                .foregroundStyle(.green)
                .opacity(0.8)
                .frame(width: 150, height: 150, alignment: .center)
                .overlay(alignment: .top) {
                    Image(systemName: "diamond.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 40, height: 40, alignment: .center)
                        .offset(y: -10.0)
                }
                .overlay(alignment: .leading) {
                    Image(systemName: "diamond.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 40, height: 40, alignment: .center)
                        .offset(x: -10.0)
                }
                .overlay(alignment: .trailing) {
                    Image(systemName: "diamond.fill")
                        .resizable()
                        .foregroundStyle(.gray)
                        .frame(width: 40, height: 40, alignment: .center)
                        .offset(x: 10.0)
                }
                .overlay(alignment: .bottom) {
                    Image(systemName: "rectangle.fill")
                        .resizable()
                        .foregroundStyle(.yellow)
                        .frame(width: 30, height: 30, alignment: .center)
                        .offset(y: 10.0)
                }
                .padding(.bottom, 10)
//
            Rectangle()
                .foregroundStyle(.clear)
                .opacity(0.2)
                .frame(width: 155, height: 155, alignment: .center)
                .overlay(alignment: .top) {
                    if let id = runner?.second.number {
                        KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(id)/spots/90"))
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                }
                .overlay(alignment: .leading) {
                    if let id = runner?.third.number {
                        KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(id)/spots/90"))
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                        
                    }
                }
                .overlay(alignment: .trailing) {
                    if let id = runner?.first.number {
                        KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(id)/spots/90"))
                            .resizable()
                            .frame(width: 25, height: 25, alignment: .center)
                    }
                }
                .overlay(alignment: .bottom, content: {
                    if let id = runner?.batter.number {
                        KFImage(URL(string: "https://midfield.mlbstatic.com/v1/people/\(id)/spots/90"))
                            .resizable()
                            .frame(width: 30, height: 30, alignment: .center)
                    }
                })
                .padding(.bottom, 10)
//
            Rectangle()
                .foregroundStyle(.clear)
                .opacity(0.2)
                .frame(width: 155 * 2, height: 155, alignment: .center)
                .overlay(alignment: .top) {
                    if let name = runner?.second.name {
                        Text(name)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            }
                            .offset(y: -34.0)
                    }
                }
                .overlay(alignment: .leading) {
                    if let name = runner?.third.name {
                        Text(name)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            }
                            .offset(y: 30)
                    }
                }
                .overlay(alignment: .trailing) {
                    if let name = runner?.first.name {
                        Text(name)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            }
                            .offset(x: -30, y: 30)
                    }
                }
                .overlay(alignment: .bottom, content: {
                    if let name = runner?.batter.name {
                        Text(name)
                            .font(.footnote)
                            .foregroundStyle(.white)
                            .padding(.horizontal, 5)
                            .padding(.vertical, 2)
                            .background {
                                RoundedRectangle(cornerRadius: 5)
                                    .foregroundStyle(.blue)
                            }
                            .offset(y: 25)
                    }
                })
        }
    }
}
