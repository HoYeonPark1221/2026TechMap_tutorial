@available(visionOS 26.0, *)
extension View {
    public func rotation3DLayout(_ angle: Angle, axis: RotationAxis3D) -> some View {
        modifier(LayoutRotationUnaryLayout(axis: axis, angle: angle))
            .rotation3DEffect(angle, axis: axis, anchor: .center)
    }
}
