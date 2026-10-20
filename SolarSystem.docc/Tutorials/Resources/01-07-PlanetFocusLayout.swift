import SwiftUI
import RealityKit

struct PlanetFocusLayout: View {
    @MainActor
    private final class Scene {
        let root = Entity()
        var planets: [PlanetID: PlanetEntity] = [:]
    }

    @Environment(AppModel.self) private var model

    var configuration: PlanetEntity.Configuration

    @State private var scene = Scene()
    @State private var measured: SIMD3<Float> = [0.7, 0.7, 0.7]

    @PhysicalMetric(from: .meters) private var pointsPerMeter: CGFloat = 1
    @PhysicalMetric(from: .meters) private var spacing: CGFloat = 0.1

    private static let panelScale: CGFloat = 1.4
    private static let panelSize = CGSize(width: 760, height: 520)

    var body: some View {
        HStackLayout(spacing: spacing).depthAlignment(.center) {
            RealityView { content in
                content.add(scene.root)
                content.add(Self.makeKeyLight())
            }
            .frame(width: CGFloat(measured.x) * pointsPerMeter,
                   height: CGFloat(measured.y) * pointsPerMeter)
            .frame(depth: CGFloat(measured.z) * pointsPerMeter)
            .task(id: configuration.id) {
                await show(configuration)
            }

            PlanetInfoPanel(
                planetID: configuration.id,
                onPrevious: { model.focusPrevious() },
                onNext: { model.focusNext() },
                onClose: { model.closeFocus() })
        }
    }

    @MainActor
    private func show(_ configuration: PlanetEntity.Configuration) async {
        let planet: PlanetEntity
        if let built = scene.planets[configuration.id] {
            planet = built
        } else {
            planet = await PlanetEntity(configuration: Self.focusConfiguration(configuration))
            scene.planets[configuration.id] = planet
            scene.root.addChild(planet)
        }

        let focusScale = PlanetEntity.focusScale(for: configuration)

        planet.scale = SIMD3(repeating: focusScale)
        let extents = planet.visualBounds(relativeTo: scene.root).extents

        for (id, entity) in scene.planets {
            entity.isEnabled = (id == configuration.id)
        }

        withAnimation(AppModel.focusTransition) {
            measured = extents
        }

        planet.scale = SIMD3(repeating: 1)
        planet.move(
            to: Transform(scale: SIMD3(repeating: focusScale)),
            relativeTo: scene.root,
            duration: AppModel.focusDuration)
    }

    private static func focusConfiguration(_ base: PlanetEntity.Configuration) -> PlanetEntity.Configuration {
        var configuration = base
        configuration.orbitRadius = 0
        configuration.initialOrbitAngle = .zero
        configuration.revolutionSpeed = 0
        configuration.sceneCenter = .zero
        configuration.presentationTilt = .init(angle: 0, axis: [0, 1, 0])
        configuration.axialTilt = .zero
        configuration.isHidden = false
        return configuration
    }

    private static func makeKeyLight() -> Entity {
        let light = Entity()
        light.components.set(DirectionalLightComponent(color: .white, intensity: 2000))
        light.look(at: .zero, from: [-0.8, 0.8, 1.5], relativeTo: nil)
        light.position = .zero
        return light
    }
}
