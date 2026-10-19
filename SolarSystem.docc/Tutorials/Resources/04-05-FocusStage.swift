import SwiftUI
import RealityKit

struct FocusStage: View {
    @Binding var stageEntity: Entity?
    var isActive: Bool

    @State private var keyLight: Entity?

    var body: some View {
        RealityView { content in
            let stage = Entity()
            stage.name = "FocusStage"
            stage.position = [0, 1.4, -1.6]
            content.add(stage)
            stageEntity = stage

            let light = Entity()
            light.components.set(DirectionalLightComponent(color: .white, intensity: 2000))
            stage.addChild(light)
            light.look(at: .zero, from: [-0.8, 0.8, 1.5], relativeTo: stage)
            light.isEnabled = isActive
            keyLight = light

        } update: { _ in
            keyLight?.isEnabled = isActive
        }
    }
}
