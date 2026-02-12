import SwiftUI

struct NewChatView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = ContactsViewModel()
    @State private var searchText = ""
    @State private var selectedUsers: Set<String> = []
    @State private var isCreatingGroup = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                // Selected users (for group chat)
                if !selectedUsers.isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(Array(selectedUsers), id: \.self) { userId in
                                if let user = viewModel.contacts.first(where: { $0.id == userId }) {
                                    SelectedUserChip(user: user) {
                                        selectedUsers.remove(userId)
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    .frame(height: 80)
                    .background(Color(.systemGray6))
                }
                
                // Contacts list
                List {
                    // New Group option
                    Button {
                        isCreatingGroup = true
                    } label: {
                        HStack(spacing: 12) {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 56, height: 56)
                                .overlay(
                                    Image(systemName: "person.3.fill")
                                        .font(.system(size: 24))
                                        .foregroundColor(.white)
                                )
                            
                            Text("New Group")
                                .font(.system(size: 16, weight: .semibold))
                            
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider()
                        .padding(.leading, 76)
                    
                    // Contacts
                    ForEach(filteredContacts) { user in
                        Button {
                            if selectedUsers.isEmpty {
                                startDirectChat(with: user)
                            } else {
                                toggleUserSelection(user)
                            }
                        } label: {
                            HStack(spacing: 12) {
                                AvatarView(name: user.displayName, size: 56)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(user.displayName)
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.primary)
                                    
                                    Text(user.isOnline ? "online" : "offline")
                                        .font(.system(size: 14))
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                                
                                if selectedUsers.contains(user.id) {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 24))
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .listStyle(.plain)
            }
            .navigationTitle("New Chat")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                if !selectedUsers.isEmpty {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Create") {
                            createGroupChat()
                        }
                    }
                }
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
    
    private func toggleUserSelection(_ user: User) {
        if selectedUsers.contains(user.id) {
            selectedUsers.remove(user.id)
        } else {
            selectedUsers.insert(user.id)
        }
    }
    
    private func startDirectChat(with user: User) {
        // In production, create or open existing chat
        dismiss()
    }
    
    private func createGroupChat() {
        // In production, create group chat with selected users
        dismiss()
    }
}

struct SelectedUserChip: View {
    let user: User
    let onRemove: () -> Void
    
    var body: some View {
        VStack(spacing: 4) {
            ZStack(alignment: .topTrailing) {
                AvatarView(name: user.displayName, size: 48)
                
                Button(action: onRemove) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                        .background(Circle().fill(Color.white))
                }
                .offset(x: 4, y: -4)
            }
            
            Text(user.displayName.split(separator: " ").first ?? "")
                .font(.caption)
                .lineLimit(1)
        }
        .frame(width: 60)
    }
}

#Preview {
    NewChatView()
}
