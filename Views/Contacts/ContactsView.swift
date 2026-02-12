import SwiftUI

struct ContactsView: View {
    @StateObject private var viewModel = ContactsViewModel()
    @State private var searchText = ""
    @State private var showingAddContact = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                // Contacts list
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredContacts) { user in
                            ContactRowView(user: user) {
                                viewModel.startChat(with: user)
                            }
                            
                            Divider()
                                .padding(.leading, 76)
                        }
                    }
                }
            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddContact = true
                    } label: {
                        Image(systemName: "person.badge.plus")
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
            .sheet(isPresented: $showingAddContact) {
                AddContactView()
            }
        }
    }
    
    private var filteredContacts: [User] {
        if searchText.isEmpty {
            return viewModel.contacts
        }
        return viewModel.contacts.filter { user in
            user.displayName.localizedCaseInsensitiveContains(searchText) ||
            user.username.localizedCaseInsensitiveContains(searchText)
        }
    }
}

struct ContactRowView: View {
    let user: User
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            HStack(spacing: 12) {
                // Avatar
                ZStack(alignment: .bottomTrailing) {
                    AvatarView(name: user.displayName, size: 56)
                    
                    if user.isOnline {
                        Circle()
                            .fill(Color.green)
                            .frame(width: 16, height: 16)
                            .overlay(
                                Circle()
                                    .stroke(Color(.systemBackground), lineWidth: 2)
                            )
                    }
                }
                
                // User info
                VStack(alignment: .leading, spacing: 4) {
                    Text(user.displayName)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Text(user.isOnline ? "online" : "last seen \(formatLastSeen(user.lastSeen))")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func formatLastSeen(_ date: Date) -> String {
        let interval = Date().timeIntervalSince(date)
        
        if interval < 60 {
            return "just now"
        } else if interval < 3600 {
            let minutes = Int(interval / 60)
            return "\(minutes)m ago"
        } else if interval < 86400 {
            let hours = Int(interval / 3600)
            return "\(hours)h ago"
        } else {
            let days = Int(interval / 86400)
            return "\(days)d ago"
        }
    }
}

class ContactsViewModel: ObservableObject {
    @Published var contacts: [User] = []
    
    init() {
        loadContacts()
    }
    
    func loadContacts() {
        // Mock data
        contacts = [
            User(username: "alice", displayName: "Alice Johnson", bio: "Hey there!", isOnline: true),
            User(username: "bob", displayName: "Bob Smith", bio: "Available", isOnline: false, lastSeen: Date().addingTimeInterval(-3600)),
            User(username: "charlie", displayName: "Charlie Brown", bio: "At work", isOnline: true),
            User(username: "diana", displayName: "Diana Prince", bio: "Busy", isOnline: false, lastSeen: Date().addingTimeInterval(-7200)),
            User(username: "emma", displayName: "Emma Watson", bio: "In a meeting", isOnline: false, lastSeen: Date().addingTimeInterval(-1800)),
            User(username: "frank", displayName: "Frank Ocean", bio: "Listening to music", isOnline: true),
            User(username: "grace", displayName: "Grace Lee", bio: "Coding", isOnline: true),
            User(username: "henry", displayName: "Henry Ford", bio: "Driving", isOnline: false, lastSeen: Date().addingTimeInterval(-86400))
        ]
    }
    
    func startChat(with user: User) {
        // In production, create or navigate to existing chat
        print("Starting chat with \(user.displayName)")
    }
}

#Preview {
    ContactsView()
}
