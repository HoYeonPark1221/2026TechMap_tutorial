import RealityKit
import SwiftUI

@main
struct SolarSystemApp: App {

    @State private var model = AppModel()

    @State private var solarImmersionStyle: ImmersionStyle = .full

    var body: some SwiftUI.Scene {
        WindowGroup {
            ToggleImmersiveSpaceButton()
                .padding(40)
                .glassBackgroundEffect()
                .environment(model)
        }
        .windowStyle(.plain)

        ImmersiveSpace(id: model.immersiveSpaceID) {
            SolarSystem()
                .environment(model)
        }
        .immersionStyle(selection: $solarImmersionStyle, in: .full)
     }
}
