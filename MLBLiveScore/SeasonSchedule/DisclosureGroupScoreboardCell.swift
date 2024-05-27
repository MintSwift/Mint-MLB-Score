import SwiftUI
import MLBPresenter

struct DisclosureGroupScoreboardCell: View {
  
    let game: GamePresenter
    @Binding var isOpen: Bool
    @State private var rotationAngle: Double = 0
    
    var body: some View {
        DisclosureGroup(
            isExpanded: $isOpen,
            content: {
                LineScoreBoardView(linescore: game.linescore,
                                   awayTeamName: game.away.abbreviation,
                                   homwTeamName: game.home.abbreviation)
                .padding(.vertical, 10)
            },
            label: {
                VStack {
                    HStack {
                        VStack {
                            HStack {
                                VStack(alignment: .trailing) {
                                    TeamInfoView(position: .away, team: game.away)
                                }
                                
                                GameStatusView(game.status)
                                
                                VStack(alignment: .leading) {
                                    TeamInfoView(position: .home, team: game.home)
                                    
                                }
                            }
//                            
                            if game.status.status == .inProgress {
                                
                            } else if game.status.status == .final {
                                HStack(alignment: .top) {
                                    VStack(alignment: .trailing) {
                                        DecisionsPitcherView(position: .away, team: game.away)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    GameStatusView(game.status)
                                        .opacity(0.0)
                                    
                                    VStack(alignment: .leading) {
                                        DecisionsPitcherView(position: .home, team: game.home)
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                            } else {
                                HStack(alignment: .top) {
                                    VStack(alignment: .trailing) {
                                        
                                        ProbablePitcherView(pitcher: game.away.probablePitcher)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    
                                    GameStatusView(game.status)
                                        .opacity(0.0)
                                    
                                    VStack(alignment: .leading) {
                                        
                                        ProbablePitcherView(pitcher: game.home.probablePitcher)
                                        
                                    }
                                    .frame(maxWidth: .infinity, alignment: .center)
                                }
                            }
                        }
                        .padding(.top, 15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    
                    Image(systemName: "chevron.up")
                        .padding(.top, 5)
                        .padding(.bottom, 10)
                        .foregroundStyle(.tertiary)
                        .rotationEffect(Angle(degrees: rotationAngle))

                }
                .onChange(of: isOpen, { oldValue, newValue in
                    withAnimation(.easeInOut(duration: 0.3)) {
                        rotationAngle += 180
                    }
                })
                
            }
        )
    }
}

#Preview {
    SeasonScheduleView()
}
class ExpansionHandler<T: Equatable>: ObservableObject {
    @Published private (set) var expandedItem: T?

    func isExpanded(_ item: T) -> Binding<Bool> {
        return Binding(
            get: { item == self.expandedItem },
            set: { self.expandedItem = $0 == true ? item : nil }
        )
    }

    func toggleExpanded(for item: T) {
        self.expandedItem = self.expandedItem == item ? nil : item
    }
}

// Usage:
// Some `Equatable` type, can also use basic types like `String` or `Date`.
enum ExpandableSection: Equatable {
    case section
    case anotherSection
}

