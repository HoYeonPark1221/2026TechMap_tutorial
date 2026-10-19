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
        RealityView { content, _ in
            let planetEntity = await PlanetEntity(configuration: configuration)
            content.add(planetEntity)
            self.planetEntity = planetEntity

        } update: { _, attachments in
            guard let planetEntity else { return }
            planetEntity.update(configuration: configuration, animateUpdates: true)

            guard let focusStage, let panel = attachments.entity(for: PlanetInfoPanel.attachmentID) else { return }
            planetEntity.setFocused(isFocused, stage: focusStage)

            if isFocused {
                if panel.parent !== focusStage {
                    focusStage.addChild(panel)
                }
                panel.position = [PlanetEntity.focusPanelOffset, 0, 0]
                panel.scale = SIMD3(repeating: PlanetEntity.focusPanelScale)
            }

        } attachments: {
            Attachment(id: PlanetInfoPanel.attachmentID) {
                PlanetInfoPanel(
                    planetID: configuration.id,
                    onPrevious: { model.focusPrevious() },
                    onNext: { model.focusNext() },
                    onClose: { model.closeFocus() })
                .opacity(isFocused ? 1 : 0)
                .allowsHitTesting(isFocused)
            }
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
