import RealityKit
import SwiftUI

class PlanetEntity: Entity {

    private let orbitPivot = Entity()
    private let radiusOffset = Entity()
    private let equatorialPlane = Entity()
    private let rotator = Entity()
    private let orbitPath = Entity()
    private var model: Entity = Entity()

    private var earthEntity: EarthEntity?

    let planetID: PlanetID
    private var configuration: Configuration

    @MainActor required init() {
        planetID = .mercury
        configuration = .mercury
        super.init()
    }

    init(configuration: Configuration) async {
        self.planetID = configuration.id
        self.configuration = configuration
        super.init()

        addChild(orbitPivot)
        addChild(orbitPath)
        orbitPivot.addChild(radiusOffset)
        radiusOffset.addChild(equatorialPlane)
        equatorialPlane.addChild(rotator)

        position = configuration.sceneCenter
        orientation = configuration.presentationTilt

        Self.configureOrbitPath(orbitPath, orbitRadius: configuration.orbitRadius)

        orbitPivot.orientation = .init(angle: Float(configuration.initialOrbitAngle.radians), axis: [0, 1, 0])

        equatorialPlane.orientation = Self.tiltOrientation(configuration.axialTilt)
    }
}
