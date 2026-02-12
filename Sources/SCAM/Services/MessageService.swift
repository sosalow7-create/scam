import Foundation
import Combine

// Service for handling message operations
class MessageService: ObservableObject {
    static let shared = MessageService()
    
    @Published var messages: [String: [Message]] = [:] // ChatId -> Messages
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    // MARK: - Send Message
    func sendMessage(
        chatId: String,
        content: String,
        type: MessageType = .text,
        senderId: String
    ) -> AnyPublisher<Message, Error> {
        let message = Message(
            chatId: chatId,
            senderId: senderId,
            content: content,
            type: type,
            status: .sending
        )
        
        // Add to local storage
        if messages[chatId] == nil {
            messages[chatId] = []
        }
        messages[chatId]?.append(message)
        
        // Simulate network request
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                var sentMessage = message
                sentMessage.status = .sent
                promise(.success(sentMessage))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Load Messages
    func loadMessages(for chatId: String) -> AnyPublisher<[Message], Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                // In production, fetch from backend/database
                promise(.success(self.messages[chatId] ?? []))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Delete Message
    func deleteMessage(messageId: String, from chatId: String) {
        messages[chatId]?.removeAll { $0.id == messageId }
    }
    
    // MARK: - Mark as Read
    func markAsRead(chatId: String, messageIds: [String]) {
        guard var chatMessages = messages[chatId] else { return }
        
        for (index, message) in chatMessages.enumerated() {
            if messageIds.contains(message.id) {
                chatMessages[index].status = .read
            }
        }
        
        messages[chatId] = chatMessages
    }
}
