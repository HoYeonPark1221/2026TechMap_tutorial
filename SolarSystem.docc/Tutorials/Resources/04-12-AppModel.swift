import RealityKit
import SwiftUI

@MainActor
@Observable
class AppModel {
    // ... 몰입 공간 상태, 행성 설정 생략

    var focusedPlanetID: PlanetID? = nil

    @ObservationIgnored let headTracker = HeadTracker()

    let focusDistance: Float = 1.3

    func placeFocusStageInFrontOfViewer(_ stage: Entity) {
        guard let head = headTracker.headTransform() else { return }

        let headPosition = SIMD3<Float>(head.columns.3.x, head.columns.3.y, head.columns.3.z)
        var forward = -SIMD3<Float>(head.columns.2.x, 0, head.columns.2.z)
        guard length(forward) > 0.001 else { return }
        forward = normalize(forward)

        let yaw = atan2(-forward.x, -forward.z)
        let orientation = simd_quatf(angle: yaw, axis: [0, 1, 0])
        let right = orientation.act([1, 0, 0])

        let groupLeft = -PlanetEntity.focusDisplayRadius
        let groupRight = PlanetEntity.focusPanelOffset + PlanetEntity.focusPanelHalfWidth
        let groupCenter = (groupLeft + groupRight) / 2

        stage.orientation = orientation
        stage.position = headPosition + forward * focusDistance - right * groupCenter
    }

    // ... focusNext(), focusPrevious(), closeFocus(), 태양 위치 생략
}
