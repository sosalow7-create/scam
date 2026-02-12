import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @State private var notificationsEnabled = true
    @State private var showOnlineStatus = true
    @State private var readReceipts = true
    @State private var showingEditProfile = false
    @State private var showingAbout = false
    
    var body: some View {
        NavigationView {
            List {
                // Profile section
                Section {
                    Button {
                        showingEditProfile = true
                    } label: {
                        HStack(spacing: 16) {
                            AvatarView(
                                name: appState.currentUser?.displayName ?? "User",
                                size: 64
                            )
                            
                            VStack(alignment: .leading, spacing: 4) {
                                Text(appState.currentUser?.displayName ?? "User")
                                    .font(.title3.bold())
                                    .foregroundColor(.primary)
                                
                                Text("@\(appState.currentUser?.username ?? "username")")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text("Tap to edit profile")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.secondary)
                                .font(.system(size: 14))
                        }
                        .padding(.vertical, 8)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                
                // Privacy & Security
                Section {
                    Toggle("Show Online Status", isOn: $showOnlineStatus)
                    Toggle("Read Receipts", isOn: $readReceipts)
                    
                    NavigationLink {
                        BlockedUsersView()
                    } label: {
                        HStack {
                            Image(systemName: "hand.raised.fill")
                                .foregroundColor(.red)
                            Text("Blocked Users")
                        }
                    }
                } header: {
                    Text("Privacy & Security")
                }
                
                // Notifications
                Section {
                    Toggle("Notifications", isOn: $notificationsEnabled)
                    
                    if notificationsEnabled {
                        NavigationLink("Notification Settings") {
                            NotificationSettingsView()
                        }
                    }
                } header: {
                    Text("Notifications")
                }
                
                // Appearance
                Section {
                    NavigationLink {
                        AppearanceSettingsView()
                    } label: {
                        HStack {
                            Image(systemName: "paintbrush.fill")
                                .foregroundColor(.purple)
                            Text("Appearance")
                        }
                    }
                } header: {
                    Text("Appearance")
                }
                
                // Data & Storage
                Section {
                    NavigationLink {
                        DataStorageView()
                    } label: {
                        HStack {
                            Image(systemName: "internaldrive.fill")
                                .foregroundColor(.orange)
                            Text("Data & Storage")
                        }
                    }
                } header: {
                    Text("Data & Storage")
                }
                
                // About
                Section {
                    NavigationLink {
                        AboutView()
                    } label: {
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .foregroundColor(.blue)
                            Text("About")
                        }
                    }
                    
                    HStack {
                        Text("Version")
                        Spacer()
                        Text("1.0.0")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Text("About")
                }
                
                // Logout
                Section {
                    Button(role: .destructive) {
                        appState.logout()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Log Out")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                }
            }
            .navigationTitle("Settings")
            .sheet(isPresented: $showingEditProfile) {
                EditProfileView()
            }
        }
    }
}

// Placeholder views for settings sections
struct BlockedUsersView: View {
    var body: some View {
        List {
            Text("No blocked users")
                .foregroundColor(.secondary)
        }
        .navigationTitle("Blocked Users")
    }
}

struct NotificationSettingsView: View {
    @State private var messageNotifications = true
    @State private var groupNotifications = true
    @State private var soundEnabled = true
    
    var body: some View {
        List {
            Toggle("Message Notifications", isOn: $messageNotifications)
            Toggle("Group Notifications", isOn: $groupNotifications)
            Toggle("Sound", isOn: $soundEnabled)
        }
        .navigationTitle("Notifications")
    }
}

struct AppearanceSettingsView: View {
    @State private var selectedTheme = "System"
    let themes = ["Light", "Dark", "System"]
    
    var body: some View {
        List {
            Section {
                ForEach(themes, id: \.self) { theme in
                    Button {
                        selectedTheme = theme
                    } label: {
                        HStack {
                            Text(theme)
                                .foregroundColor(.primary)
                            Spacer()
                            if selectedTheme == theme {
                                Image(systemName: "checkmark")
                                    .foregroundColor(.blue)
                            }
                        }
                    }
                }
            } header: {
                Text("Theme")
            }
        }
        .navigationTitle("Appearance")
    }
}

struct DataStorageView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Messages")
                    Spacer()
                    Text("2.3 MB")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Media")
                    Spacer()
                    Text("156 MB")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Cache")
                    Spacer()
                    Text("45 MB")
                        .foregroundColor(.secondary)
                }
            } header: {
                Text("Storage Usage")
            }
            
            Section {
                Button("Clear Cache") {
                    // Clear cache
                }
                
                Button("Clear All Data", role: .destructive) {
                    // Clear all data
                }
            }
        }
        .navigationTitle("Data & Storage")
    }
}

struct AboutView: View {
    var body: some View {
        List {
            Section {
                HStack {
                    Text("Version")
                    Spacer()
                    Text("1.0.0")
                        .foregroundColor(.secondary)
                }
                
                NavigationLink("Terms of Service") {
                    Text("Terms of Service content")
                }
                
                NavigationLink("Privacy Policy") {
                    Text("Privacy Policy content")
                }
                
                NavigationLink("Open Source Licenses") {
                    Text("Licenses content")
                }
            }
            
            Section {
                VStack(spacing: 8) {
                    Image(systemName: "message.circle.fill")
                        .font(.system(size: 60))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("SCAM Messenger")
                        .font(.title2.bold())
                    
                    Text("Simple. Clean. Minimalist.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding()
            }
        }
        .navigationTitle("About")
    }
}

struct EditProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var displayName = ""
    @State private var bio = ""
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack {
                        AvatarView(name: displayName.isEmpty ? "User" : displayName, size: 100)
                        
                        Button("Change Photo") {
                            // Change photo
                        }
                        .font(.subheadline)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                
                Section {
                    TextField("Display Name", text: $displayName)
                    TextField("Bio", text: $bio, axis: .vertical)
                        .lineLimit(3...6)
                }
            }
            .navigationTitle("Edit Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        // Save changes
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(AppState())
}
