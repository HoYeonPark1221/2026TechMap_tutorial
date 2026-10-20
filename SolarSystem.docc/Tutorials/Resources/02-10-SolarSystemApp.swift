import RealityKit
import SwiftUI
import WorldAssets

@main
struct SolarSystemApp: App {

    @State private var model = AppModel()

    @State private var solarImmersionStyle: ImmersionStyle = .full

    init() {
        RotationSystem.registerSystem()
        TraceSystem.registerSystem()
        SunPositionSystem.registerSystem()
    }

    var body: some SwiftUI.Scene {
        WindowGroup {
            SwitchWindows()
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
