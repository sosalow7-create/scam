import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    @Published var messageText = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    let chat: Chat
    let currentUserId: String
    private var cancellables = Set<AnyCancellable>()
    
    init(chat: Chat, currentUserId: String = "current") {
        self.chat = chat
        self.currentUserId = currentUserId
        loadMessages()
    }
    
    func loadMessages() {
        isLoading = true
        
        // In production, fetch from backend
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.loadMockMessages()
            self.isLoading = false
        }
    }
    
    func sendMessage() {
        guard !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        
        let newMessage = Message(
            chatId: chat.id,
            senderId: currentUserId,
            content: messageText,
            type: .text,
            status: .sending
        )
        
        messages.append(newMessage)
        messageText = ""
        
        // Simulate sending
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            if let index = self?.messages.firstIndex(where: { $0.id == newMessage.id }) {
                self?.messages[index].status = .sent
            }
        }
    }
    
    func deleteMessage(_ message: Message) {
        messages.removeAll { $0.id == message.id }
    }
    
    func isMessageFromCurrentUser(_ message: Message) -> Bool {
        message.senderId == currentUserId
    }
    
    // Mock data
    private func loadMockMessages() {
        let otherUserId = chat.participants.first { $0 != currentUserId } ?? "other"
        
        messages = [
            Message(chatId: chat.id, senderId: otherUserId, content: "Hi there!", timestamp: Date().addingTimeInterval(-3600)),
            Message(chatId: chat.id, senderId: currentUserId, content: "Hello! How are you?", timestamp: Date().addingTimeInterval(-3500)),
            Message(chatId: chat.id, senderId: otherUserId, content: "I'm doing great, thanks for asking!", timestamp: Date().addingTimeInterval(-3400)),
            Message(chatId: chat.id, senderId: currentUserId, content: "That's wonderful to hear!", timestamp: Date().addingTimeInterval(-3300)),
            Message(chatId: chat.id, senderId: otherUserId, content: "What have you been up to lately?", timestamp: Date().addingTimeInterval(-3200)),
            Message(chatId: chat.id, senderId: currentUserId, content: "Working on a new project. It's really exciting!", timestamp: Date().addingTimeInterval(-3100)),
            Message(chatId: chat.id, senderId: otherUserId, content: "That sounds amazing! Tell me more about it.", timestamp: Date().addingTimeInterval(-3000)),
        ]
    }
}
