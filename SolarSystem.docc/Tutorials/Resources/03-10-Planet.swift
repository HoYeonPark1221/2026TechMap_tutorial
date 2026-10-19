import SwiftUI
import RealityKit

struct Planet: View {
    var configuration: PlanetEntity.Configuration

    @State private var planetEntity: PlanetEntity?

    var body: some View {
        RealityView { content in
            let planetEntity = await PlanetEntity(configuration: configuration)
            content.add(planetEntity)
            self.planetEntity = planetEntity

        } update: { _ in
            guard let planetEntity else { return }
            planetEntity.update(configuration: configuration, animateUpdates: true)
        }
    }
}
