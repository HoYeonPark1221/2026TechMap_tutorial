import SwiftUI

struct ToggleImmersiveSpaceButton: View {

    @Environment(AppModel.self) private var model

    @Environment(\.dismissImmersiveSpace) private var dismissImmersiveSpace
    @Environment(\.openImmersiveSpace) private var openImmersiveSpace

    var body: some View {
        Button {
            Task { @MainActor in
                switch model.immersiveSpaceState {
                    case .open:
                        model.immersiveSpaceState = .inTransition
                        await dismissImmersiveSpace()

                    case .closed:
                        model.immersiveSpaceState = .inTransition
                        switch await openImmersiveSpace(id: model.immersiveSpaceID) {
                            case .opened:
                                break

                            case .userCancelled, .error:
                                fallthrough
                            @unknown default:
                                model.immersiveSpaceState = .closed
                        }

                    case .inTransition:
                        break
                }
            }
        } label: {
            Text(model.immersiveSpaceState == .open ? "Exit the Solar System" : "Going to the Solar System")
        }
        .disabled(model.immersiveSpaceState == .inTransition)
        .animation(.none, value: 0)
        .fontWeight(.semibold)
    }
}
