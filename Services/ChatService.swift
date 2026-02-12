import Foundation
import Combine

// Service for handling chat operations
class ChatService: ObservableObject {
    static let shared = ChatService()
    
    @Published var chats: [Chat] = []
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        loadChats()
    }
    
    // MARK: - Load Chats
    func loadChats() {
        // In production, fetch from backend/database
        // For now, we'll use mock data
    }
    
    // MARK: - Create Chat
    func createChat(
        type: ChatType,
        participants: [String],
        name: String? = nil
    ) -> AnyPublisher<Chat, Error> {
        let chat = Chat(
            type: type,
            name: name,
            participants: participants
        )
        
        return Future { [weak self] promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self?.chats.append(chat)
                promise(.success(chat))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Delete Chat
    func deleteChat(chatId: String) {
        chats.removeAll { $0.id == chatId }
    }
    
    // MARK: - Update Chat
    func updateChat(_ chat: Chat) {
        if let index = chats.firstIndex(where: { $0.id == chat.id }) {
            chats[index] = chat
        }
    }
    
    // MARK: - Find or Create Direct Chat
    func findOrCreateDirectChat(
        with userId: String,
        currentUserId: String
    ) -> AnyPublisher<Chat, Error> {
        // Check if chat already exists
        if let existingChat = chats.first(where: {
            $0.type == .direct &&
            $0.participants.contains(userId) &&
            $0.participants.contains(currentUserId)
        }) {
            return Just(existingChat)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        
        // Create new chat
        return createChat(
            type: .direct,
            participants: [currentUserId, userId]
        )
    }
}
