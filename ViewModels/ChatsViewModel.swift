import Foundation
import Combine

class ChatsViewModel: ObservableObject {
    @Published var chats: [Chat] = []
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadMockData()
    }
    
    func loadChats() {
        isLoading = true
        
        // In production, fetch from backend/Firebase
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.isLoading = false
        }
    }
    
    func deleteChat(_ chat: Chat) {
        chats.removeAll { $0.id == chat.id }
    }
    
    func togglePin(_ chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].isPinned.toggle()
            sortChats()
        }
    }
    
    func toggleMute(_ chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].isMuted.toggle()
        }
    }
    
    func markAsRead(_ chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index].unreadCount = 0
        }
    }
    
    private func sortChats() {
        chats.sort { chat1, chat2 in
            if chat1.isPinned != chat2.isPinned {
                return chat1.isPinned
            }
            return chat1.lastMessageTime > chat2.lastMessageTime
        }
    }
    
    // Mock data for demonstration
    private func loadMockData() {
        users = [
            User(username: "alice", displayName: "Alice", isOnline: true),
            User(username: "bob", displayName: "Bob", isOnline: false, lastSeen: Date().addingTimeInterval(-3600)),
            User(username: "charlie", displayName: "Charlie", isOnline: true),
            User(username: "diana", displayName: "Diana", isOnline: false, lastSeen: Date().addingTimeInterval(-7200))
        ]
        
        let mockMessages = [
            Message(chatId: "chat1", senderId: users[0].id, content: "Hey! How are you?", timestamp: Date().addingTimeInterval(-300)),
            Message(chatId: "chat2", senderId: users[1].id, content: "Did you see the new design?", timestamp: Date().addingTimeInterval(-1800)),
            Message(chatId: "chat3", senderId: users[2].id, content: "Let's meet tomorrow", timestamp: Date().addingTimeInterval(-3600)),
            Message(chatId: "chat4", senderId: users[3].id, content: "Thanks for your help!", timestamp: Date().addingTimeInterval(-86400))
        ]
        
        chats = [
            Chat(id: "chat1", type: .direct, participants: ["current", users[0].id], lastMessage: mockMessages[0], lastMessageTime: mockMessages[0].timestamp, unreadCount: 2),
            Chat(id: "chat2", type: .direct, participants: ["current", users[1].id], lastMessage: mockMessages[1], lastMessageTime: mockMessages[1].timestamp, unreadCount: 0, isPinned: true),
            Chat(id: "chat3", type: .direct, participants: ["current", users[2].id], lastMessage: mockMessages[2], lastMessageTime: mockMessages[2].timestamp, unreadCount: 1),
            Chat(id: "chat4", type: .group, name: "Team", participants: ["current", users[3].id], lastMessage: mockMessages[3], lastMessageTime: mockMessages[3].timestamp, unreadCount: 5)
        ]
        
        sortChats()
    }
}
