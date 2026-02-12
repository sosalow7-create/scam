# SCAM Messenger - Development Guide

## 🏗️ Architecture

### MVVM Pattern
The app follows the Model-View-ViewModel architecture:

- **Models**: Data structures (`User`, `Message`, `Chat`)
- **Views**: SwiftUI views for UI
- **ViewModels**: Business logic and state management
- **Services**: Backend communication layer

### Project Structure

```
SCAM/
├── Models/                 # Data models
│   ├── User.swift
│   ├── Message.swift
│   └── Chat.swift
├── ViewModels/            # View models
│   ├── ChatsViewModel.swift
│   └── ChatViewModel.swift
├── Views/                 # SwiftUI views
│   ├── Authentication/
│   ├── Chats/
│   ├── Contacts/
│   ├── Settings/
│   └── Components/
├── Services/              # Business logic services
│   ├── MessageService.swift
│   ├── ChatService.swift
│   └── UserService.swift
├── Utilities/             # Helper functions and extensions
└── Assets.xcassets/       # Images and colors
```

## 🎨 Design Principles

### Minimalism
- Clean, distraction-free interface
- Generous use of white space
- Simple color palette
- Focus on content

### User Experience
- Smooth animations and transitions
- Haptic feedback for interactions
- Intuitive navigation
- Consistent design patterns

### Performance
- Lazy loading of lists
- Efficient memory management
- Optimized images and assets
- Background processing for heavy tasks

## 🔧 Key Features

### 1. Authentication
- Simple username/display name login
- Persistent session storage
- Easy logout

### 2. Chat List
- Real-time updates
- Pull to refresh
- Search functionality
- Pin/mute/delete actions
- Unread count badges

### 3. Messaging
- Text messages
- Message status indicators (sending/sent/delivered/read)
- Time-based message grouping
- Copy/delete message actions
- Smooth scrolling to latest message

### 4. Contacts
- Contact list with online status
- Search contacts
- Add new contacts
- Start direct chats

### 5. Settings
- Profile editing
- Privacy controls
- Notification settings
- Appearance customization
- Data management

## 🚀 Getting Started

### Requirements
- macOS 13.0+
- Xcode 14.0+
- iOS 16.0+ (deployment target)

### Building the App
1. Open `SCAM.xcodeproj` in Xcode
2. Select a simulator or device
3. Press `Cmd + R` to build and run

### Running Tests
```bash
# Run all tests
xcodebuild test -scheme SCAM

# Run specific test suite
xcodebuild test -scheme SCAM -only-testing:SCAMTests/UserTests
```

## 🎯 Future Enhancements

### Phase 1 - Core Features
- [ ] Real backend integration (Firebase/custom API)
- [ ] Push notifications
- [ ] Image/video/file sharing
- [ ] Voice messages
- [ ] End-to-end encryption

### Phase 2 - Advanced Features
- [ ] Group chats
- [ ] Video/audio calls
- [ ] Stories/status updates
- [ ] Message reactions
- [ ] Reply to messages
- [ ] Forward messages
- [ ] Message search

### Phase 3 - Polish
- [ ] Dark mode improvements
- [ ] Custom themes
- [ ] Widgets
- [ ] Apple Watch support
- [ ] iPad optimization
- [ ] Accessibility improvements

## 🔐 Security Considerations

### Current Implementation
- Basic session storage with UserDefaults
- No encryption (development only)

### Production Requirements
- Use Keychain for sensitive data
- Implement end-to-end encryption
- Secure WebSocket connections (WSS)
- API authentication with JWT tokens
- Rate limiting and input validation
- Regular security audits

## 📱 UI Components

### Reusable Components
- `AvatarView`: User avatar with gradient background
- `SearchBar`: Custom search input
- `MessageInputBar`: Text input with send button
- `LoadingView`: Loading indicator
- `EmptyStateView`: Empty state placeholder
- `ErrorView`: Error display with retry

### Custom Animations
- `TypingIndicator`: Animated dots for typing status
- `ShimmerModifier`: Skeleton loading effect
- `BouncyButtonStyle`: Button press animation
- `PulseModifier`: Pulsing animation
- `SwipeActionModifier`: Swipe to reveal actions

## 🐛 Debugging Tips

### Common Issues

**App won't build**
- Clean build folder: `Cmd + Shift + K`
- Delete derived data: `Cmd + Shift + K` then restart Xcode
- Check minimum iOS version compatibility

**UI not updating**
- Ensure ViewModels use `@Published` for reactive properties
- Check that Views observe `@StateObject` or `@ObservedObject`

**Memory leaks**
- Use `[weak self]` in closures
- Cancel Combine subscriptions properly
- Avoid retain cycles in delegates

## 📚 Resources

### SwiftUI
- [Apple SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)
- [SwiftUI by Example](https://www.hackingwithswift.com/quick-start/swiftui)

### Design
- [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/)
- [iOS Design Patterns](https://www.raywenderlich.com/477-design-patterns-on-ios-using-swift-part-1-2)

### Combine Framework
- [Combine Documentation](https://developer.apple.com/documentation/combine)
- [Using Combine](https://heckj.github.io/swiftui-notes/)

## 🤝 Contributing

### Code Style
- Follow Swift API Design Guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use extensions to organize code

### Git Workflow
1. Create feature branch from `main`
2. Make changes with descriptive commits
3. Test thoroughly
4. Submit pull request
5. Code review and merge

## 📄 License

MIT License - Feel free to use this code for learning and personal projects.
