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

struct PitcherSeasonRecord: Identifiable, Hashable, Equatable {
    var id: String
    let era: String
    
    init(era: String) {
        self.id = UUID().uuidString
        self.era = era
    }
}

struct PitcherTodayRecord: Identifiable, Hashable, Equatable {
    var id: String

    let ip: String
    let h: String
    let r: String
    let er: String
    let bb: String
    let k: String
    let hr: String
    
    init(ip: String, h: String, r: String, er: String, bb: String, k: String, hr: String) {
        self.id = UUID().uuidString
        self.ip = ip
        self.h = h
        self.r = r
        self.er = er
        self.bb = bb
        self.k = k
        self.hr = hr
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
    
    init(ab: String,
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

struct MPlayer: Identifiable, Hashable, Equatable, Decodable {
    var id: String
    
    let name: String?
    let number: String?
    
    let battingOrder: Int
    
    let seasonRecord: SeasonRecord?
    let todayRecord: TodayRecord?
    
    let pitcherSeasonRecord: PitcherSeasonRecord?
    let pitcherTodayRecord: PitcherTodayRecord?
    
    enum CodingKeys: CodingKey {
        case person
        case stats
        case seasonStats
        case battingOrder
    }
    
    enum PersonCodingKeys: CodingKey {
        case id
        case fullName
    }
    
    enum StatsCodingKeys: CodingKey {
        case batting
        case pitching
    }
    
    enum BattingCodingKeys: CodingKey {
        case atBats
        case runs
        case hits
        case rbi
        case baseOnBalls
        case strikeOuts
        case leftOnBase
        
        case avg
        case ops
    }
    
    enum PitchingCodingKeys: CodingKey {
        case inningsPitched
        case hits
        case runs
        case earnedRuns
        case baseOnBalls
        case strikeOuts
        case homeRuns
        
        case era
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let personContainer = try container.nestedContainer(keyedBy: PersonCodingKeys.self, forKey: .person)
        self.id = UUID().uuidString
        self.name = try personContainer.decodeIfPresent(String.self, forKey: .fullName)
        let number = try personContainer.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.number = String( number )
        
        let order = try container.decodeIfPresent(String.self, forKey: .battingOrder)
        self.battingOrder = Int(order ?? "000") ?? 0
        
        let stateContainer = try container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .stats)
        let battingContainer = try stateContainer.nestedContainer(keyedBy: BattingCodingKeys.self, forKey: .batting)
        
        let ab = try battingContainer.decodeIfPresent(Int.self, forKey: .atBats) ?? 0
        let r = try battingContainer.decodeIfPresent(Int.self, forKey: .runs) ?? 0
        let h = try battingContainer.decodeIfPresent(Int.self, forKey: .hits) ?? 0
        let rbi = try battingContainer.decodeIfPresent(Int.self, forKey: .rbi) ?? 0
        let bb = try battingContainer.decodeIfPresent(Int.self, forKey: .baseOnBalls) ?? 0
        let k = try battingContainer.decodeIfPresent(Int.self, forKey: .strikeOuts) ?? 0
        let lob = try battingContainer.decodeIfPresent(Int.self, forKey: .leftOnBase) ?? 0
        
        self.todayRecord = TodayRecord(ab: String(ab), r: String(r), h: String(h), rbi: String(rbi), bb: String(bb), k: String(k), lob: String(lob))
        
        let seasonStatsContainer = try container.nestedContainer(keyedBy: StatsCodingKeys.self, forKey: .seasonStats)
        
        let seasonBattingContainer = try seasonStatsContainer.nestedContainer(keyedBy: BattingCodingKeys.self, forKey: .batting)
        let avg = try seasonBattingContainer.decodeIfPresent(String.self, forKey: .avg) ?? ".000"
        let ops = try seasonBattingContainer.decodeIfPresent(String.self, forKey: .ops) ?? ".000"
        
        self.seasonRecord = SeasonRecord(avg: avg, ops: ops)
        
        let pitchingContainer = try stateContainer.nestedContainer(keyedBy: PitchingCodingKeys.self, forKey: .pitching)
        let p_ip = try pitchingContainer.decodeIfPresent(String.self, forKey: .inningsPitched) ?? "0.0"
        let p_h = try pitchingContainer.decodeIfPresent(Int.self, forKey: .hits) ?? 0
        let p_r = try pitchingContainer.decodeIfPresent(Int.self, forKey: .runs) ?? 0
        let p_er = try pitchingContainer.decodeIfPresent(Int.self, forKey: .earnedRuns) ?? 0
        let p_bb = try pitchingContainer.decodeIfPresent(Int.self, forKey: .baseOnBalls) ?? 0
        let p_k = try pitchingContainer.decodeIfPresent(Int.self, forKey: .strikeOuts) ?? 0
        let p_hr = try pitchingContainer.decodeIfPresent(Int.self, forKey: .homeRuns) ?? 0
        self.pitcherTodayRecord = PitcherTodayRecord(ip: String(p_ip), h: String(p_h), r: String(p_r), er: String(p_er), bb: String(p_bb), k: String(p_k), hr: String(p_hr))
        
        
        let seasonPitchingContainer = try seasonStatsContainer.nestedContainer(keyedBy: PitchingCodingKeys.self, forKey: .pitching)
        let era = try seasonPitchingContainer.decodeIfPresent(String.self, forKey: .era) ?? ".000"

        
        self.pitcherSeasonRecord = PitcherSeasonRecord(era: era)
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
                            .offset(y: 20)
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
