import SwiftUI

struct AuthenticationView: View {
    @EnvironmentObject var appState: AppState
    @State private var username = ""
    @State private var displayName = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Spacer()
                
                // Logo
                VStack(spacing: 12) {
                    Image(systemName: "message.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("SCAM")
                        .font(.system(size: 48, weight: .bold, design: .rounded))
                    
                    Text("Simple. Clean. Minimalist.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom, 60)
                
                // Input fields
                VStack(spacing: 16) {
                    TextField("Username", text: $username)
                        .textFieldStyle(MinimalTextFieldStyle())
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    
                    TextField("Display Name", text: $displayName)
                        .textFieldStyle(MinimalTextFieldStyle())
                }
                .padding(.horizontal, 32)
                
                // Sign in button
                Button {
                    signIn()
                } label: {
                    HStack {
                        if isLoading {
                            ProgressView()
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                        } else {
                            Text("Continue")
                                .fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(isFormValid ? Color.primary : Color.secondary.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .disabled(!isFormValid || isLoading)
                .padding(.horizontal, 32)
                .padding(.top, 24)
                
                Spacer()
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
    
    private var isFormValid: Bool {
        !username.isEmpty && !displayName.isEmpty
    }
    
    private func signIn() {
        isLoading = true
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let user = User(
                username: username,
                displayName: displayName,
                isOnline: true
            )
            appState.login(user: user)
            isLoading = false
        }
    }
}

// Custom minimal text field style
struct MinimalTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)
    }
}

#Preview {
    AuthenticationView()
        .environmentObject(AppState())
}
