import SwiftUI
import MLBPresenter

struct ScoreboardCell: View {
    @StateObject private var expansionHandler = ExpansionHandler<ExpandableSection>()
    @State var isOpen: Bool = false
    @State private var rotationAngle: Double = 0
    
    let game: GamePresenter
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                CollableScoreboardCell(game: game)
                
                HStack {
                    Image(systemName: "chevron.up")
                        .scaledToFit()
                        .padding(.vertical, 3)
                        .foregroundStyle(.tertiary)
                        .rotationEffect(Angle(degrees: rotationAngle))
                        .frame(maxWidth: .infinity)
                }
                .background(.white)
                .onTapGesture {
                    Task {
                        isOpen.toggle()
                        
                        try? await Task.sleep(for: .milliseconds(50))
                        
                        withAnimation {
                            rotationAngle += 180
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            VStack {
                if isOpen {
                    VStack {
                        if game.status.status == .inProgress {
                            
                        } else if game.status.status == .final {
                            DecisionsContainerView(game: game)

                        } else {
                            ProbableContainerView(game: game)

                        }
                        
                        if game.status.status == .inProgress || game.status.status == .final {
                            LineScoreBoardView(linescore: game.linescore,
                                               awayTeamName: game.away.abbreviation,
                                               homwTeamName: game.home.abbreviation)
                        }
                    }

                    .padding(.vertical, 10)
                }
            }
            .frame(height: isOpen ? nil : 0, alignment: .bottom)
            .clipped()
            
            Divider()
        }
    }
}

#Preview {
    SeasonScheduleView()
}
