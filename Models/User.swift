import Foundation

struct User: Identifiable, Codable, Equatable {
    let id: String
    var username: String
    var displayName: String
    var avatarURL: String?
    var bio: String?
    var phoneNumber: String?
    var isOnline: Bool
    var lastSeen: Date
    
    init(
        id: String = UUID().uuidString,
        username: String,
        displayName: String,
        avatarURL: String? = nil,
        bio: String? = nil,
        phoneNumber: String? = nil,
        isOnline: Bool = false,
        lastSeen: Date = Date()
    ) {
        self.id = id
        self.username = username
        self.displayName = displayName
        self.avatarURL = avatarURL
        self.bio = bio
        self.phoneNumber = phoneNumber
        self.isOnline = isOnline
        self.lastSeen = lastSeen
    }
    
    static var mockUser: User {
        User(
            username: "user123",
            displayName: "John Doe",
            bio: "Hello, I'm using SCAM!",
            isOnline: true
        )
    }
}
