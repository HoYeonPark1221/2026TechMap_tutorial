import RealityKit
import SwiftUI

class PlanetEntity: Entity {
    // ... 엔티티 프로퍼티 생략

    let planetID: PlanetID
    private var configuration: Configuration
    private var isFocused = false

    // ... init(), init(configuration:) 생략

    func update(configuration: Configuration, animateUpdates: Bool) {
        self.configuration = configuration

        isEnabled = !configuration.isHidden

        radiusOffset.position = [0, 0, configuration.orbitRadius]

        setRotationSpeed(isFocused ? 0 : configuration.currentRevolutionSpeed, on: orbitPivot)
        setRotationSpeed(configuration.currentRotationSpeed, on: rotator)

        // ... 모델 갱신 생략
    }

    // ... setRotationSpeed(_:on:) 생략

    static let focusDisplayRadius: Float = 0.35
    static let focusPanelScale: Float = 1.4
    static let focusPanelHalfWidth: Float = 0.28 * focusPanelScale
    static let focusPanelOffset: Float = focusDisplayRadius + 0.1 + focusPanelHalfWidth

    private var focusScale: Float {
        Self.focusDisplayRadius / max(configuration.ringRadius, 0.05)
    }

    func setFocused(_ focused: Bool, stage: Entity, animated: Bool = true) {
        guard focused != isFocused else { return }
        isFocused = focused

        let newParent = focused ? stage : radiusOffset
        newParent.addChild(equatorialPlane, preservingWorldTransform: true)

        let scale: Float = focused ? focusScale : 1
        let target = Transform(
            scale: SIMD3(repeating: scale),
            rotation: Self.tiltOrientation(configuration.axialTilt),
            translation: .zero)
        if animated {
            equatorialPlane.move(to: target, relativeTo: newParent, duration: 0.6)
        } else {
            equatorialPlane.move(to: target, relativeTo: newParent)
        }

        setRotationSpeed(focused ? 0 : configuration.currentRevolutionSpeed, on: orbitPivot)
    }

    // ... configureSelectionTarget(_:planetID:radius:) 생략
}
