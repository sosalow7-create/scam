import Foundation
import Combine

// Service for handling user operations
class UserService: ObservableObject {
    static let shared = UserService()
    
    @Published var currentUser: User?
    @Published var contacts: [User] = []
    private var cancellables = Set<AnyCancellable>()
    
    private init() {}
    
    // MARK: - Authentication
    func login(username: String, displayName: String) -> AnyPublisher<User, Error> {
        let user = User(
            username: username,
            displayName: displayName,
            isOnline: true
        )
        
        return Future { [weak self] promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self?.currentUser = user
                // Save to UserDefaults or Keychain
                UserDefaults.standard.set(user.id, forKey: "userId")
                promise(.success(user))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func logout() {
        currentUser = nil
        UserDefaults.standard.removeObject(forKey: "userId")
    }
    
    // MARK: - User Profile
    func updateProfile(
        displayName: String? = nil,
        bio: String? = nil,
        avatarURL: String? = nil
    ) -> AnyPublisher<User, Error> {
        guard var user = currentUser else {
            return Fail(error: NSError(domain: "UserService", code: 1, userInfo: [NSLocalizedDescriptionKey: "No current user"]))
                .eraseToAnyPublisher()
        }
        
        if let displayName = displayName {
            user.displayName = displayName
        }
        if let bio = bio {
            user.bio = bio
        }
        if let avatarURL = avatarURL {
            user.avatarURL = avatarURL
        }
        
        return Future { [weak self] promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self?.currentUser = user
                promise(.success(user))
            }
        }
        .eraseToAnyPublisher()
    }
    
    // MARK: - Contacts
    func searchUser(username: String) -> AnyPublisher<User?, Error> {
        return Future { promise in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                // In production, search in backend
                // For demo, return mock user
                if username.lowercased() == "test" {
                    let user = User(
                        username: username,
                        displayName: "Test User",
                        bio: "This is a test account"
                    )
                    promise(.success(user))
                } else {
                    promise(.success(nil))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addContact(_ user: User) {
        if !contacts.contains(where: { $0.id == user.id }) {
            contacts.append(user)
        }
    }
    
    func removeContact(userId: String) {
        contacts.removeAll { $0.id == userId }
    }
}
