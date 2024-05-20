import SwiftUI
import SwiftDate

struct WNextGameView: View {
    
    let info: GameInfo?
    

    var game: Game?
    var away: TeamStandings?
    var home: TeamStandings?
    
    let winnerRecord: PitcherPerson?
    let loserRecord: PitcherPerson?
    
    init(info: GameInfo?) {
        self.info = info
        self.game = info?.game
        self.away = info?.awayTeamStandings
        self.home = info?.homeTeamStandings
        self.winnerRecord = info?.winnerPlayerRecord
        self.loserRecord = info?.loserPlayerRecord
    }
    
    var body: some View {
        VStack {
            if let game {
                HStack(alignment: .center) {
                    NextGameTeamView(stadium: .away, team: game.away, standings: away, winnerRecord: winnerRecord, loserRecord: loserRecord)
                    
                    VStack(spacing: 10) {
                        Text("VS.")
                        Text(game.date.toFormat("MM/dd a hh:mm", locale: Locales.korean))
                    }
                    .foregroundStyle(.secondary)
                    .font(.caption2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    NextGameTeamView(stadium: .home, team: game.home, standings: home, winnerRecord: winnerRecord, loserRecord: loserRecord)
                }
            }
        }
    }
}

struct NextGameTeamView: View {
    let stadium: Stadium
    let team: Team
    let standings: TeamStandings?
    
    let winnerRecord: PitcherPerson?
    let loserRecord: PitcherPerson?
    
    
    init(stadium: Stadium, team: Team, standings: TeamStandings?, winnerRecord: PitcherPerson?, loserRecord: PitcherPerson?) {
        self.stadium = stadium
        self.team = team
        self.standings = standings
        
        self.winnerRecord = winnerRecord
        self.loserRecord = loserRecord
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            VStack {
                if let team = MLBTeam.all.first(where: { $0 .code == Int(team.teamID) }) {
                    Image(team.abbreviation)
                        .resizable()
                        .frame(width: 30, height: 30, alignment: .center)
                        .scaledToFit()
                }
                
                VStack {
                    Text(team.franchiseName)
                    Text(team.teamName)
                }
                .font(.footnote)
                .fontWeight(.semibold)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .padding(.leading, 5)
            }
            
            VStack(spacing: 2) {
                VStack {
                    if let standings {
                        Text("\(standings.wins) - \(standings.losses)")
                        
                        Text("\(standings.divisionRank.ordinal() ?? "") \(standings.divisionShortName)")
                    }
                }
                .font(.caption2)
                .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            
            VStack(spacing: 2) {
                HStack(spacing: 4) {
                    Image(systemName: "p.square.fill")
                        .resizable()
                        .frame(width: 10, height: 10)
                        .foregroundStyle(.secondary)
                    
                    Text(team.probablePitcher.name ?? "TBD")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.5)
                }
                .frame(alignment: .leading)
                
                if stadium == .away {
                    if let winnerRecord {
                        Text("\(winnerRecord.wins) - \(winnerRecord.losses) | \(winnerRecord.era)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
                
                if stadium == .home {
                    if let loserRecord {
                        Text("\(loserRecord.wins) - \(loserRecord.losses) | \(loserRecord.era)")
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
    }
}

extension String {
    func ordinal() -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .ordinal
        if let e = Int(self) {
            return formatter.string(from: NSNumber(integerLiteral: e))
        }
        
        return nil
    }
}

