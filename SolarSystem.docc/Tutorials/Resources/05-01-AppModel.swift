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
    var isShowingSolar: Bool = false

    // ... 행성 설정, 포커스, 머리 추적 생략
}
