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

    func focusNext() {
        focusedPlanetID = (focusedPlanetID ?? .neptune).next
    }

    func focusPrevious() {
        focusedPlanetID = (focusedPlanetID ?? .mercury).previous
    }

    func closeFocus() {
        focusedPlanetID = nil
    }

    let solarSunPosition: SIMD3<Float> = [0, 1.0, -9]
    let solarSunScale: Float = 2.0

    let solarSystemTilt: simd_quatf = .init(angle: Float(Angle.degrees(28).radians), axis: [1, 0, 0])
}
