import SwiftUI
import MLBPresenter

struct ScoreboardCell: View {
    @State var isOpen: Bool = false
    @State private var rotationAngle: Double = 0
    @Environment(\.colorScheme) var colorScheme
    let game: GamePresenter
    
    var body: some View {
        VStack(spacing: 0) {
            VStack {
                HeaderScoreboardCell(game: game)
                
                PitcherInfoView(game: game)
                
                if game.status.status == .inProgress || game.status.status == .final {
                    chevronImage
                }
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            if isOpen {
                VStack {
                    if game.status.status == .inProgress || game.status.status == .final {
                        LineScoreBoardView(linescore: game.linescore,
                                           awayTeamName: game.away.abbreviation,
                                           homwTeamName: game.home.abbreviation)
                    }
                }
                .padding(.vertical, 10)
            }
            
            Divider()
        }
    }
    
    var chevronImage: some View {
        HStack {
            Image(systemName: "chevron.up")
                .scaledToFit()
                .padding(.vertical, 3)
                .foregroundStyle(.tertiary)
                .rotationEffect(Angle(degrees: rotationAngle))
        }
        .frame(maxWidth: .infinity)
        .background(colorScheme == .light ?  Color.background : Color.secondaryBackground)
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
}

#Preview {
    SeasonScheduleView()
}
