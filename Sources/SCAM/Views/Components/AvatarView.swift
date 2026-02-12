import SwiftUI

struct AvatarView: View {
    let name: String
    let size: CGFloat
    let imageURL: String?
    
    init(name: String, size: CGFloat = 40, imageURL: String? = nil) {
        self.name = name
        self.size = size
        self.imageURL = imageURL
    }
    
    var body: some View {
        ZStack {
            Circle()
                .fill(gradientForName(name))
                .frame(width: size, height: size)
            
            Text(initials)
                .font(.system(size: size * 0.4, weight: .semibold))
                .foregroundColor(.white)
        }
    }
    
    private var initials: String {
        let components = name.split(separator: " ")
        let initials = components.prefix(2).compactMap { $0.first }.map { String($0) }
        return initials.joined().uppercased()
    }
    
    private func gradientForName(_ name: String) -> LinearGradient {
        let colors: [[Color]] = [
            [.blue, .purple],
            [.pink, .orange],
            [.green, .blue],
            [.red, .pink],
            [.purple, .blue],
            [.orange, .red],
            [.cyan, .blue],
            [.mint, .green]
        ]
        
        let hash = abs(name.hashValue)
        let colorPair = colors[hash % colors.count]
        
        return LinearGradient(
            colors: colorPair,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

#Preview {
    HStack(spacing: 20) {
        AvatarView(name: "John Doe", size: 60)
        AvatarView(name: "Alice Smith", size: 60)
        AvatarView(name: "Bob Johnson", size: 60)
    }
    .padding()
}
