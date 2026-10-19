import SwiftUI
import RealityKit

struct SolarSystem: View {
    @Environment(AppModel.self) private var model

    var body: some View {
        ZStack {
            Starfield()

            Sun(
                scale: model.solarSunScale,
                position: model.solarSunPosition
            )
        }
        .onAppear {
            model.immersiveSpaceState = .open
            var announcement = AttributedString(localized: "Entered the immersive star filled solar system!",
                                                comment: "Accessibility message describing the model shown.")
            announcement.accessibilitySpeechAnnouncementPriority = .high
            AccessibilityNotification.Announcement(announcement).post()
        }
        .onDisappear {
            model.immersiveSpaceState = .closed
        }
    }
}
