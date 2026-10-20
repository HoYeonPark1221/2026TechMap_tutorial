import RealityKit
import SwiftUI

@MainActor
@Observable
class AppModel {

    var solarEarth: EarthEntity.Configuration = .solarEarthDefault
    var solarSatellite: SatelliteEntity.Configuration = .solarTelescopeDefault
    var solarMoon: SatelliteEntity.Configuration = .solarMoonDefault

    var solarPlanets: [PlanetEntity.Configuration] {
        let planets: [PlanetEntity.Configuration] = [
            .mercury,
            .venus,
            .makeEarth(configuration: solarEarth, satellites: [solarSatellite], moon: solarMoon),
            .mars,
            .jupiter,
            .saturn,
            .uranus,
            .neptune
        ]
        return planets.map {
            var configuration = $0
            configuration.sceneCenter = solarSunPosition
            configuration.presentationTilt = solarSystemTilt
            configuration.isHidden = focusedPlanetID != nil
            return configuration
        }
    }

    var focusedPlanetID: PlanetID? = nil

    var focusedConfiguration: PlanetEntity.Configuration? {
        guard let focusedPlanetID else { return nil }
        return solarPlanets.first { $0.id == focusedPlanetID }
    }

    @ObservationIgnored let headTracker = HeadTracker()

    let focusDistance: Float = 1.3

    struct FocusPlacement: Equatable {
        var yaw: Float = 0
        var position: SIMD3<Float> = [0, 1.4, -1.6]
    }

    private(set) var focusPlacement = FocusPlacement()

    func updateFocusPlacement() {
        guard let head = headTracker.headTransform() else { return }

        let headPosition = SIMD3<Float>(head.columns.3.x, head.columns.3.y, head.columns.3.z)
        var forward = -SIMD3<Float>(head.columns.2.x, 0, head.columns.2.z)
        guard length(forward) > 0.001 else { return }
        forward = normalize(forward)

        focusPlacement = FocusPlacement(
            yaw: atan2(-forward.x, -forward.z),
            position: headPosition + forward * focusDistance)
    }

    static let focusDuration: TimeInterval = 0.6
    static let focusTransition: Animation = .easeInOut(duration: focusDuration)

    func focusNext() {
        withAnimation(Self.focusTransition) {
            focusedPlanetID = (focusedPlanetID ?? .neptune).next
        }
    }

    func focusPrevious() {
        withAnimation(Self.focusTransition) {
            focusedPlanetID = (focusedPlanetID ?? .mercury).previous
        }
    }

    func closeFocus() {
        withAnimation(Self.focusTransition) {
            focusedPlanetID = nil
        }
    }

    let solarSunPosition: SIMD3<Float> = [0, 1.0, -9]
    let solarSunScale: Float = 2.0

    let solarSystemTilt: simd_quatf = .init(angle: Float(Angle.degrees(28).radians), axis: [1, 0, 0])
}
