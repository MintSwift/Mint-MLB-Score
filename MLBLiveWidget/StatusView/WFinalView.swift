import SwiftUI

struct WFinalView: View {
    var info: GameInfo?
    
    var game: Game?
    var away: TeamStandings?
    var home: TeamStandings?
    
    let winnerRecord: PitcherPerson?
    let loserRecord: PitcherPerson?
    
    init(info: GameInfo?) {
        self.game = info?.game
        self.away = info?.awayTeamStandings
        self.home = info?.homeTeamStandings
        self.winnerRecord = info?.winnerPlayerRecord
        self.loserRecord = info?.loserPlayerRecord
    }
    
    var body: some View {
        HStack {
            if let game {
                VStack {
                    FinalGameTeamView(stadium: .away, team: game.away, score: game.awayScore, standings: away, game: game, winnerRecord: winnerRecord, loserRecord: loserRecord)
                }
                
                VStack {
                    Text("Final")
                }
                .font(.footnote)
                
                VStack {
                    FinalGameTeamView(stadium: .home, team: game.home, score: game.homeScore, standings: home, game: game, winnerRecord: winnerRecord, loserRecord: loserRecord)
                }
            }
        }
    }
}
struct FinalGameTeamView: View {
    let stadium: Stadium
    let team: Team
    let standings: TeamStandings?
    let score: String
    let game: Game
    let winnerRecord: PitcherPerson?
    let loserRecord: PitcherPerson?
    
    init(stadium: Stadium, team: Team, score: String, standings: TeamStandings?, game: Game, winnerRecord: PitcherPerson?, loserRecord: PitcherPerson?) {
        self.stadium = stadium
        self.team = team
        self.standings = standings
        self.score = score
        self.game = game
        
        self.winnerRecord = loserRecord
        self.loserRecord = loserRecord
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            HStack {
                if stadium == .home {
                    Text(score)
                        .font(.title)
                        .padding(.trailing, 15)
                }
                
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
                
                if stadium == .away {
                    Text(score)
                    .font(.title)
                    .padding(.leading, 15)
                }
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
            
            if stadium == .away && game.away.isWinner == true {
                // Away팀 승리했고 승리투수
                VStack(alignment: .trailing, spacing: 2) {
                    if let winnerPitcher = game.winnerPitcher?.name {
                        HStack {
                            Text(winnerPitcher)
                                .font(.caption2)
                            
                            Image(systemName: "w.square.fill")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 12, height: 12, alignment: .center)
                        }
                    }
                    
                    if let savePitcher = game.savePitcher?.name {
                        HStack {
                            Text(savePitcher)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                            
                            Image(systemName: "s.square.fill")
                                .resizable()
                                .foregroundStyle(.blue)
                                .frame(width: 12, height: 12, alignment: .center)
                        }
                    }
                }
                .frame(height: 30)
            }
            if stadium == .away && game.home.isWinner == true {
                // Away팀 패배했고, 패전투수
                if let loserPitcher = game.loserPitcher?.name {
                    HStack {
                        Text(loserPitcher)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                        
                        Image(systemName: "l.square.fill")
                            .resizable()
                            .foregroundStyle(.gray)
                            .frame(width: 12, height: 12, alignment: .center)
                    }
                    .frame(height: 30)
                }
            }
            
            if stadium == .home && game.home.isWinner == true {
                // Home팀 승리했고, 승리투스
                VStack(alignment: .leading, spacing: 2) {
                    if let winnerPitcher = game.winnerPitcher?.name {
                        HStack {
                            Image(systemName: "w.square.fill")
                                .resizable()
                                .foregroundStyle(.red)
                                .frame(width: 12, height: 12, alignment: .center)
                            Text(winnerPitcher)
                                .font(.caption2)
                        }
                    }
                    
                    if let savePitcher = game.savePitcher?.name {
                        HStack {
                            Image(systemName: "s.square.fill")
                                .resizable()
                                .foregroundStyle(.blue)
                                .frame(width: 12, height: 12, alignment: .center)
                            Text(savePitcher)
                                .font(.caption2)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
                .frame(height: 30)
            }
            
            if stadium == .home && game.away.isWinner == true {
                // Home팀 패배했고, 패전투스
                if let loserPitcher = game.loserPitcher?.name {
                    HStack {
                        Image(systemName: "l.square.fill")
                            .resizable()
                            .foregroundStyle(.gray)
                            .frame(width: 12, height: 12, alignment: .center)
                        Text(loserPitcher)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    .frame(height: 30)
                }
            }
        
         
        }
    }
}
