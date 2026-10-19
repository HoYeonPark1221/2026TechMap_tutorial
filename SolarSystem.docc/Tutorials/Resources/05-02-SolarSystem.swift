import SwiftUI
import RealityKit

struct SolarSystem: View {
    @Environment(AppModel.self) private var model

    @State private var focusStage: Entity?

    var body: some View {
        ZStack {
            Starfield()

            Sun(
                scale: model.solarSunScale,
                position: model.solarSunPosition,
                isHidden: model.focusedPlanetID != nil
            )

            FocusStage(stageEntity: $focusStage, isActive: model.focusedPlanetID != nil)

            ForEach(model.solarPlanets, id: \.id) { configuration in
                Planet(configuration: configuration, focusStage: focusStage)
            }
        }
        .onAppear {
            model.immersiveSpaceState = .open
            model.isShowingSolar = true
            var announcement = AttributedString(localized: "Entered the immersive star filled solar system!",
                                                comment: "Accessibility message describing the model shown.")
            announcement.accessibilitySpeechAnnouncementPriority = .high
            AccessibilityNotification.Announcement(announcement).post()
        }
        .task {
            await model.headTracker.start()
        }
        .onDisappear {
            model.headTracker.stop()
            model.immersiveSpaceState = .closed
            model.isShowingSolar = false
        }
    }
}
