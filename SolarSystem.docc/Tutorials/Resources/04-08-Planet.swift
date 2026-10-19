import SwiftUI
import RealityKit

struct Planet: View {
    @Environment(AppModel.self) private var model

    var configuration: PlanetEntity.Configuration
    var focusStage: Entity?

    @State private var planetEntity: PlanetEntity?

    private var isFocused: Bool {
        model.focusedPlanetID == configuration.id
    }

    var body: some View {
        RealityView { content in
            let planetEntity = await PlanetEntity(configuration: configuration)
            content.add(planetEntity)
            self.planetEntity = planetEntity

        } update: { _ in
            guard let planetEntity else { return }
            planetEntity.update(configuration: configuration, animateUpdates: true)

            guard let focusStage else { return }
            planetEntity.setFocused(isFocused, stage: focusStage)
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
