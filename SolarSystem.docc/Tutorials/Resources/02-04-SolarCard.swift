import SwiftUI

struct SolarCard: View {
    @Environment(AppModel.self) private var model
    @Environment(\.openWindow) private var openWindow
    var module: Module

    var body: some View {
        @Bindable var model = model

        GeometryReader { proxy in
            let textWidth = min(max(proxy.size.width * 0.4, 300), 500)
            let imageWidth = min(max(proxy.size.width - textWidth, 300), 700)
            ZStack {
                HStackLayout(spacing: 60).depthAlignment(.center) {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(module.heading)
                            .font(.system(size: 50, weight: .bold))
                            .padding(.bottom, 15)
                            .accessibilitySortPriority(4)

                        Text(module.overview)
                            .padding(.bottom, 24)
                            .accessibilitySortPriority(3)

                        ToggleImmersiveSpaceButton()
                    }
                    .frame(width: textWidth, alignment: .leading)

                    module.detailView
                        .frame(width: imageWidth, alignment: .center)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .padding([.leading, .trailing], 70)
        .padding(.bottom, 24)
        .background {
            if module == .solar {
                Image("SolarBackground")
                    .resizable()
                    .scaledToFill()
                    .accessibility(hidden: true)
            }
        }

   }
}

extension Module {
    @ViewBuilder
    fileprivate var detailView: some View {
        SolarSystemModule()
    }
}

#Preview("Solar System") {
    NavigationStack {
        SolarCard(module: .solar)
            .environment(AppModel())
    }
}
