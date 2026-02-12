import Foundation

enum MessageType: String, Codable {
    case text
    case image
    case video
    case audio
    case file
}

enum MessageStatus: String, Codable {
    case sending
    case sent
    case delivered
    case read
    case failed
}

struct Message: Identifiable, Codable, Equatable {
    let id: String
    let chatId: String
    let senderId: String
    let content: String
    let type: MessageType
    let timestamp: Date
    var status: MessageStatus
    var isEdited: Bool
    var replyToMessageId: String?
    
    init(
        id: String = UUID().uuidString,
        chatId: String,
        senderId: String,
        content: String,
        type: MessageType = .text,
        timestamp: Date = Date(),
        status: MessageStatus = .sent,
        isEdited: Bool = false,
        replyToMessageId: String? = nil
    ) {
        self.id = id
        self.chatId = chatId
        self.senderId = senderId
        self.content = content
        self.type = type
        self.timestamp = timestamp
        self.status = status
        self.isEdited = isEdited
        self.replyToMessageId = replyToMessageId
    }
    
    var isFromCurrentUser: Bool {
        // In production, compare with actual current user
        return false // Placeholder
    }
}
