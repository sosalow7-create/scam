import SwiftUI

struct AddContactView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var username = ""
    @State private var isSearching = false
    @State private var foundUser: User?
    @State private var errorMessage: String?
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                // Header
                VStack(spacing: 8) {
                    Image(systemName: "person.crop.circle.badge.plus")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                    
                    Text("Add New Contact")
                        .font(.title2.bold())
                }
                .padding(.top, 40)
                
                // Search field
                VStack(spacing: 16) {
                    TextField("Enter username", text: $username)
                        .textFieldStyle(MinimalTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding(.horizontal)
                    
                    if let error = errorMessage {
                        Text(error)
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                    
                    if let user = foundUser {
                        VStack(spacing: 16) {
                            AvatarView(name: user.displayName, size: 80)
                            
                            VStack(spacing: 4) {
                                Text(user.displayName)
                                    .font(.title3.bold())
                                
                                Text("@\(user.username)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                if let bio = user.bio {
                                    Text(bio)
                                        .font(.body)
                                        .foregroundColor(.secondary)
                                        .multilineTextAlignment(.center)
                                        .padding(.top, 4)
                                }
                            }
                            
                            Button {
                                addContact(user)
                            } label: {
                                Text("Add Contact")
                                    .fontWeight(.semibold)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(16)
                        .padding(.horizontal)
                    } else if !username.isEmpty {
                        Button {
                            searchUser()
                        } label: {
                            HStack {
                                if isSearching {
                                    ProgressView()
                                        .progressViewStyle(CircularProgressViewStyle())
                                } else {
                                    Text("Search")
                                        .fontWeight(.semibold)
                                }
                            }
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                        }
                        .disabled(isSearching)
                        .padding(.horizontal)
                    }
                }
                
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func searchUser() {
        isSearching = true
        errorMessage = nil
        foundUser = nil
        
        // Simulate network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            isSearching = false
            
            // Mock search result
            if username.lowercased() == "test" {
                foundUser = User(
                    username: username,
                    displayName: "Test User",
                    bio: "This is a test account"
                )
            } else {
                errorMessage = "User not found"
            }
        }
    }
    
    private func addContact(_ user: User) {
        // In production, add to contacts list
        dismiss()
    }
}

#Preview {
    AddContactView()
}
