import RealityKit
import SwiftUI

class PlanetEntity: Entity {
    // ... 프로퍼티와 init() 생략

    init(configuration: Configuration) async {
        // ... 계층 연결, 초기 방향, 모델 로딩 생략
        rotator.addChild(model)

        update(configuration: configuration, animateUpdates: false)
    }

    func update(configuration: Configuration, animateUpdates: Bool) {
        self.configuration = configuration

        isEnabled = !configuration.isHidden

        radiusOffset.position = [0, 0, configuration.orbitRadius]

        setRotationSpeed(configuration.currentRevolutionSpeed, on: orbitPivot)
        setRotationSpeed(configuration.currentRotationSpeed, on: rotator)

        switch configuration.modelKind {
        case let .earth(earthConfiguration, satellites, moon):
            earthEntity?.update(
                configuration: earthConfiguration,
                satelliteConfiguration: satellites,
                moonConfiguration: moon,
                animateUpdates: animateUpdates)

        case .placeholder:
            model.scale = SIMD3(repeating: configuration.visualRadius)
        }
    }

    private func setRotationSpeed(_ speed: Float, on entity: Entity) {
        if var rotation: RotationComponent = entity.components[RotationComponent.self] {
            rotation.speed = speed
            entity.components[RotationComponent.self] = rotation
        } else {
            entity.components.set(RotationComponent(speed: speed))
        }
    }
}
