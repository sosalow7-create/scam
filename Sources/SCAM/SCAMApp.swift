import SwiftUI

@main
struct SCAMApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
        }
    }
}

// App-wide state management
class AppState: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var isDarkMode = false
    
    init() {
        // Check for stored authentication
        checkAuthStatus()
    }
    
    private func checkAuthStatus() {
        // In production, check keychain or secure storage
        // For demo, we'll simulate
        if let userId = UserDefaults.standard.string(forKey: "userId") {
            isAuthenticated = true
            // Load user data
        }
    }
    
    func login(user: User) {
        currentUser = user
        isAuthenticated = true
        UserDefaults.standard.set(user.id, forKey: "userId")
    }
    
    func logout() {
        currentUser = nil
        isAuthenticated = false
        UserDefaults.standard.removeObject(forKey: "userId")
    }
}
