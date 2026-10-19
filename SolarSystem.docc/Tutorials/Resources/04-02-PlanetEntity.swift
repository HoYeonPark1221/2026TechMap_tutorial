import RealityKit
import SwiftUI

class PlanetEntity: Entity {

    private let orbitPivot = Entity()
    private let radiusOffset = Entity()
    private let equatorialPlane = Entity()
    private let rotator = Entity()
    private let orbitPath = Entity()
    private let selectionTarget = Entity()

    // ... 나머지 프로퍼티와 init() 생략

    init(configuration: Configuration) async {
        // ... 계층 연결, 초기 방향, 모델 로딩 생략
        rotator.addChild(model)

        rotator.addChild(selectionTarget)
        Self.configureSelectionTarget(selectionTarget, planetID: configuration.id, radius: configuration.ringRadius)

        update(configuration: configuration, animateUpdates: false)
    }

    // ... update(configuration:animateUpdates:), setRotationSpeed(_:on:) 생략

    private static func configureSelectionTarget(_ target: Entity, planetID: PlanetID, radius: Float) {
        target.name = "\(planetID.displayName)-selectionTarget"
        target.components.set(PlanetSelectionComponent(planetID: planetID))
        target.components.set(InputTargetComponent())
        target.components.set(HoverEffectComponent())
        target.components.set(CollisionComponent(shapes: [.generateSphere(radius: max(radius, 0.05))]))
    }
}
