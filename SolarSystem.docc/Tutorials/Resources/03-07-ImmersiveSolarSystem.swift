import SwiftUI
import RealityKit

struct ImmersiveSolarSystem: View {
    @Environment(AppModel.self) private var model

    @PhysicalMetric(from: .meters) private var pointsPerMeter: CGFloat = 1

    var body: some View {
        ZStack {
            Starfield()

            Sun(
                scale: model.solarSunScale,
                position: model.solarSunPosition,
                isHidden: model.focusedPlanetID != nil
            )

            ForEach(model.solarPlanets, id: \.id) { configuration in
                Planet(configuration: configuration)
            }

            if let focused = model.focusedConfiguration {
                PlanetFocusLayout(configuration: focused)
                    .transition(.opacity)
                    .rotation3DEffect(.radians(Double(model.focusPlacement.yaw)),
                                      axis: (x: 0, y: 1, z: 0))
                    .offset(x: CGFloat(model.focusPlacement.position.x) * pointsPerMeter,
                            y: CGFloat(-model.focusPlacement.position.y) * pointsPerMeter)
                    .offset(z: CGFloat(model.focusPlacement.position.z) * pointsPerMeter)
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
