import RealityKit
import SwiftUI
import WorldAssets

@main
struct SolarSystemApp: App {

    init() {
        RotationSystem.registerSystem()
        TraceSystem.registerSystem()
        SunPositionSystem.registerSystem()
    }

    var body: some SwiftUI.Scene {
        WindowGroup {
            Text("Solar System")
        }
     }
}
