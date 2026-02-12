import SwiftUI

struct MessageInputBar: View {
    @Binding var text: String
    let onSend: () -> Void
    @State private var inputHeight: CGFloat = 40
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            
            HStack(alignment: .bottom, spacing: 12) {
                // Attachment button
                Button {
                    // Show attachment options
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .font(.system(size: 28))
                        .foregroundColor(.secondary)
                }
                
                // Text input
                HStack(alignment: .bottom, spacing: 8) {
                    TextEditor(text: $text)
                        .frame(minHeight: 40, maxHeight: 120)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .overlay(
                            Group {
                                if text.isEmpty {
                                    Text("Message")
                                        .foregroundColor(.secondary)
                                        .padding(.leading, 16)
                                        .padding(.top, 8)
                                        .allowsHitTesting(false)
                                }
                            },
                            alignment: .topLeading
                        )
                }
                
                // Send button
                Button {
                    onSend()
                } label: {
                    Image(systemName: "arrow.up.circle.fill")
                        .font(.system(size: 32))
                        .foregroundStyle(
                            text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?
                            LinearGradient(colors: [.secondary], startPoint: .top, endPoint: .bottom) :
                            LinearGradient(colors: [.blue, .blue.opacity(0.7)], startPoint: .topLeading, endPoint: .bottomTrailing)
                        )
                }
                .disabled(text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(.systemBackground))
        }
    }
}

#Preview {
    VStack {
        Spacer()
        MessageInputBar(text: .constant(""), onSend: {})
    }
}
