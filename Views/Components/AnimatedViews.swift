import SwiftUI

// MARK: - Typing Indicator
struct TypingIndicator: View {
    @State private var animationOffset: CGFloat = 0
    
    var body: some View {
        HStack(spacing: 4) {
            ForEach(0..<3) { index in
                Circle()
                    .fill(Color.secondary)
                    .frame(width: 8, height: 8)
                    .offset(y: animationOffset)
                    .animation(
                        Animation
                            .easeInOut(duration: 0.6)
                            .repeatForever()
                            .delay(Double(index) * 0.2),
                        value: animationOffset
                    )
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(Color(.systemGray5))
        .cornerRadius(16)
        .onAppear {
            animationOffset = -5
        }
    }
}

// MARK: - Shimmer Effect
struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    gradient: Gradient(colors: [
                        .clear,
                        Color.white.opacity(0.3),
                        .clear
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(
                    Animation.linear(duration: 1.5)
                        .repeatForever(autoreverses: false)
                ) {
                    phase = 300
                }
            }
    }
}

extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}

// MARK: - Bouncy Button
struct BouncyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Slide Transition
struct SlideTransition: ViewModifier {
    let edge: Edge
    @Binding var isPresented: Bool
    
    func body(content: Content) -> some View {
        content
            .transition(.asymmetric(
                insertion: .move(edge: edge).combined(with: .opacity),
                removal: .move(edge: edge).combined(with: .opacity)
            ))
            .animation(.spring(response: 0.4, dampingFraction: 0.8), value: isPresented)
    }
}

// MARK: - Pulse Animation
struct PulseModifier: ViewModifier {
    @State private var isPulsing = false
    let duration: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.1 : 1.0)
            .opacity(isPulsing ? 0.7 : 1.0)
            .animation(
                Animation
                    .easeInOut(duration: duration)
                    .repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear {
                isPulsing = true
            }
    }
}

extension View {
    func pulse(duration: Double = 1.0) -> some View {
        modifier(PulseModifier(duration: duration))
    }
}

// MARK: - Skeleton Loader
struct SkeletonView: View {
    @State private var isAnimating = false
    let height: CGFloat
    let cornerRadius: CGFloat
    
    init(height: CGFloat = 20, cornerRadius: CGFloat = 8) {
        self.height = height
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: cornerRadius)
            .fill(Color(.systemGray5))
            .frame(height: height)
            .shimmer()
    }
}

// MARK: - Swipe Actions
struct SwipeActionModifier: ViewModifier {
    @State private var offset: CGFloat = 0
    @State private var isSwiping = false
    let onDelete: () -> Void
    let onArchive: (() -> Void)?
    
    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            // Actions background
            HStack(spacing: 0) {
                if let onArchive = onArchive {
                    Button {
                        onArchive()
                        withAnimation {
                            offset = 0
                        }
                    } label: {
                        VStack {
                            Image(systemName: "archivebox.fill")
                                .font(.title3)
                        }
                        .foregroundColor(.white)
                        .frame(width: 80)
                        .frame(maxHeight: .infinity)
                        .background(Color.orange)
                    }
                }
                
                Button {
                    onDelete()
                } label: {
                    VStack {
                        Image(systemName: "trash.fill")
                            .font(.title3)
                    }
                    .foregroundColor(.white)
                    .frame(width: 80)
                    .frame(maxHeight: .infinity)
                    .background(Color.red)
                }
            }
            .frame(width: onArchive != nil ? 160 : 80)
            .offset(x: 80)
            
            // Content
            content
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            let translation = value.translation.width
                            if translation < 0 {
                                offset = max(translation, onArchive != nil ? -160 : -80)
                            }
                        }
                        .onEnded { value in
                            withAnimation(.spring()) {
                                if offset < -40 {
                                    offset = onArchive != nil ? -160 : -80
                                } else {
                                    offset = 0
                                }
                            }
                        }
                )
        }
    }
}

extension View {
    func swipeActions(
        onDelete: @escaping () -> Void,
        onArchive: (() -> Void)? = nil
    ) -> some View {
        modifier(SwipeActionModifier(onDelete: onDelete, onArchive: onArchive))
    }
}

#Preview("Typing Indicator") {
    TypingIndicator()
        .padding()
}

#Preview("Skeleton") {
    VStack(spacing: 12) {
        SkeletonView(height: 60, cornerRadius: 12)
        SkeletonView(height: 40, cornerRadius: 8)
        SkeletonView(height: 40, cornerRadius: 8)
    }
    .padding()
}
