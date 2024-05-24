import SwiftUI
import MLBPresenter
import SwiftDate

struct GameStatusView: View {
    let status: StatusPresenter
    
    init(_ status: StatusPresenter) {
        self.status = status
    }
    
    var body: some View {
        VStack {
            if let reason = status.reason {
                Text(reason)
                    .font(.caption2)
            } else if status.status == .final {
                Text(status.status.rawValue)
                    .font(.caption2)
            } else if status.status == .scheduled {
                Text(status.date.toFormat("HH:mm", locale: Locales.korean))
                    .font(.footnote)
            } else {
                VStack {
                    Text(status.currentInning ?? "")
                    Text(status.inningState.text())
                }
                .font(.footnote)
            }
        }
    }
}
