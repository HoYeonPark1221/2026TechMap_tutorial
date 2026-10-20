import RealityKit
import SwiftUI
import WorldAssets

@main
struct SolarSystemApp: App {

    @State private var model = AppModel()

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
     }
}
