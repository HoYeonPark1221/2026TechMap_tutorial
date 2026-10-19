import SwiftUI
import RealityKit

struct Planet: View {
    @Environment(AppModel.self) private var model

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
        .gesture(
            SpatialTapGesture()
                .targetedToAnyEntity()
                .onEnded { value in
                    guard value.entity.components[PlanetSelectionComponent.self] != nil else { return }
                    model.focusedPlanetID = configuration.id
                }
        )
    }
}
