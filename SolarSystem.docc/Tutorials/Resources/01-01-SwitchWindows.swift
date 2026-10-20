import SwiftUI

struct SwitchWindows: View {
    var body: some View {
        ZStack {
            SolarSystemControls()

            SolarCard(module: .solar)
                .glassBackgroundEffect()
        }
    }
}

#Preview {
    SwitchWindows()
}
