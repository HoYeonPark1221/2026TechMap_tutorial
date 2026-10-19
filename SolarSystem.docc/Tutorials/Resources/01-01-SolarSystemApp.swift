import SwiftUI

@main
struct SolarSystemApp: App {

    var body: some SwiftUI.Scene {
        WindowGroup {
            Text("Solar System")
                .font(.extraLargeTitle)
                .padding(40)
                .glassBackgroundEffect()
        }
        .windowStyle(.plain)
     }
}
