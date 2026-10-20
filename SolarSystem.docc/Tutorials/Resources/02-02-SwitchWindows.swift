import SwiftUI

struct SwitchWindows: View {
    var body: some View {
        SpatialContainer(alignment: .center) {
            SolarSystemControls()

            SolarCard(module: .solar)
                .glassBackgroundEffect()
        }
    }
}

#Preview {
    SwitchWindows()
}
