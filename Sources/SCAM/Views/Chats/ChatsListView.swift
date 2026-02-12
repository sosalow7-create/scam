import SwiftUI

struct ChatsListView: View {
    @StateObject private var viewModel = ChatsViewModel()
    @State private var searchText = ""
    @State private var showingNewChat = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                
                // Chat list
                ScrollView {
                    LazyVStack(spacing: 0) {
                        ForEach(filteredChats) { chat in
                            NavigationLink(destination: ChatView(chat: chat)) {
                                ChatRowView(chat: chat, viewModel: viewModel)
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                            Divider()
                                .padding(.leading, 76)
                        }
                    }
                }
                .refreshable {
                    viewModel.loadChats()
                }
            }
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewChat = true
                    } label: {
                        Image(systemName: "square.and.pencil")
                            .font(.system(size: 18, weight: .medium))
                    }
                }
            }
            .sheet(isPresented: $showingNewChat) {
                NewChatView()
            }
        }
    }
    
    private var filteredChats: [Chat] {
        if searchText.isEmpty {
            return viewModel.chats
        }
        return viewModel.chats.filter { chat in
            let displayName = chat.getDisplayName(currentUserId: "current", users: viewModel.users)
            return displayName.localizedCaseInsensitiveContains(searchText)
        }
    }
}

struct ChatRowView: View {
    let chat: Chat
    @ObservedObject var viewModel: ChatsViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            // Avatar
            AvatarView(name: getDisplayName(), size: 56)
            
            // Chat info
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text(getDisplayName())
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Text(formatTime(chat.lastMessageTime))
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text(chat.lastMessage?.content ?? "No messages")
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    if chat.unreadCount > 0 {
                        Text("\(chat.unreadCount)")
                            .font(.system(size: 12, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(minWidth: 20, minHeight: 20)
                            .padding(.horizontal, 6)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    }
                    
                    if chat.isMuted {
                        Image(systemName: "bell.slash.fill")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(Color(.systemBackground))
        .contextMenu {
            Button {
                viewModel.togglePin(chat)
            } label: {
                Label(chat.isPinned ? "Unpin" : "Pin", systemImage: chat.isPinned ? "pin.slash" : "pin")
            }
            
            Button {
                viewModel.toggleMute(chat)
            } label: {
                Label(chat.isMuted ? "Unmute" : "Mute", systemImage: chat.isMuted ? "bell" : "bell.slash")
            }
            
            Button {
                viewModel.markAsRead(chat)
            } label: {
                Label("Mark as Read", systemImage: "checkmark.circle")
            }
            
            Divider()
            
            Button(role: .destructive) {
                viewModel.deleteChat(chat)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
    
    private func getDisplayName() -> String {
        chat.getDisplayName(currentUserId: "current", users: viewModel.users)
    }
    
    private func formatTime(_ date: Date) -> String {
        let calendar = Calendar.current
        let now = Date()
        
        if calendar.isDateInToday(date) {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            return formatter.string(from: date)
        } else if calendar.isDateInYesterday(date) {
            return "Yesterday"
        } else if calendar.component(.weekOfYear, from: date) == calendar.component(.weekOfYear, from: now) {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            return formatter.string(from: date)
        } else {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yy"
            return formatter.string(from: date)
        }
    }
}

#Preview {
    ChatsListView()
}
