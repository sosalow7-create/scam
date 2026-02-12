import Foundation

enum ChatType: String, Codable {
    case direct
    case group
}

struct Chat: Identifiable, Codable, Equatable {
    let id: String
    let type: ChatType
    var name: String?
    var participants: [String] // User IDs
    var lastMessage: Message?
    var lastMessageTime: Date
    var unreadCount: Int
    var avatarURL: String?
    var isMuted: Bool
    var isPinned: Bool
    
    init(
        id: String = UUID().uuidString,
        type: ChatType,
        name: String? = nil,
        participants: [String],
        lastMessage: Message? = nil,
        lastMessageTime: Date = Date(),
        unreadCount: Int = 0,
        avatarURL: String? = nil,
        isMuted: Bool = false,
        isPinned: Bool = false
    ) {
        self.id = id
        self.type = type
        self.name = name
        self.participants = participants
        self.lastMessage = lastMessage
        self.lastMessageTime = lastMessageTime
        self.unreadCount = unreadCount
        self.avatarURL = avatarURL
        self.isMuted = isMuted
        self.isPinned = isPinned
    }
    
    func getDisplayName(currentUserId: String, users: [User]) -> String {
        if type == .group {
            return name ?? "Group Chat"
        } else {
            let otherUserId = participants.first { $0 != currentUserId }
            let otherUser = users.first { $0.id == otherUserId }
            return otherUser?.displayName ?? "Unknown"
        }
    }
    
    static var mockChat: Chat {
        Chat(
            type: .direct,
            participants: ["user1", "user2"],
            lastMessageTime: Date(),
            unreadCount: 3
        )
    }
}
