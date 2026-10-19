import RealityKit
import SwiftUI

@MainActor
@Observable
class AppModel {
    let immersiveSpaceID = "SolarSystem"

    enum ImmersiveSpaceState {
        case closed
        case inTransition
        case open
    }
    var immersiveSpaceState = ImmersiveSpaceState.closed

    let solarSunPosition: SIMD3<Float> = [0, 1.0, -9]
    let solarSunScale: Float = 2.0
}
