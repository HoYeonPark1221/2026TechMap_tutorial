import SwiftUI

struct SwitchWindows: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        SpatialContainer(alignment: .center) {
            SolarSystemControls()
                .opacity(model.isShowingSolar ? 1 : 0)

            SolarCard(module: .solar)
                .glassBackgroundEffect()
                .opacity(model.isShowingSolar ? 0 : 1)
        }
        .animation(.default, value: model.isShowingSolar)
    }
}

#Preview {
    SwitchWindows()
}
