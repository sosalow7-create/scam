# SCAM Messenger 💬

> **S**imple. **C**lean. **A**nd **M**inimalist.

A modern iOS messenger app built with SwiftUI, featuring a beautiful minimalist design and smooth user experience.

![iOS](https://img.shields.io/badge/iOS-16.0+-blue.svg)
![Swift](https://img.shields.io/badge/Swift-5.7+-orange.svg)
![SwiftUI](https://img.shields.io/badge/SwiftUI-3.0+-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## ✨ Features

### 🎨 Design
- **Minimalist Interface** - Clean, distraction-free design
- **Smooth Animations** - 60 FPS transitions and interactions
- **Dark Mode** - Full support for light and dark themes
- **Modern UI** - Following iOS design guidelines

### 💬 Messaging
- **Real-time Chats** - Instant message delivery
- **Message Status** - Sending, sent, delivered, read indicators
- **Rich Interactions** - Copy, delete, reply to messages
- **Smart Search** - Find chats and contacts quickly

### 👥 Social
- **Contact Management** - Add and manage contacts
- **Online Status** - See who's online in real-time
- **User Profiles** - Customizable avatars and bios
- **Group Ready** - UI prepared for group chats

### ⚙️ Customization
- **Profile Editing** - Change name, bio, avatar
- **Privacy Controls** - Manage online status and read receipts
- **Notification Settings** - Customize alerts
- **Appearance Options** - Light, dark, or system theme

## 🚀 Quick Start

### Requirements
- macOS 13.0+
- Xcode 14.0+
- iOS 16.0+ (deployment target)

### Installation
```bash
# 1. Open project in Xcode
open SCAM.xcodeproj

# 2. Select target device/simulator

# 3. Build and run
Cmd + R
```

See [QUICKSTART.md](QUICKSTART.md) for detailed setup instructions.

## 📱 Screenshots

The app features:
- **Chats List** - All conversations with search and filters
- **Chat View** - Beautiful message bubbles with smooth scrolling
- **Contacts** - Browse and add new contacts
- **Settings** - Comprehensive customization options

## 🏗️ Architecture

Built with modern iOS development practices:

- **MVVM Pattern** - Clear separation of concerns
- **Combine Framework** - Reactive programming
- **SwiftUI** - Declarative UI
- **Service Layer** - Business logic abstraction
- **Reusable Components** - DRY principles

```
SCAM/
├── Models/           # Data structures
├── ViewModels/       # Business logic
├── Views/            # SwiftUI views
├── Services/         # Backend services
├── Utilities/        # Helper functions
└── Assets.xcassets/  # Images and colors
```

## 📚 Documentation

- [QUICKSTART.md](QUICKSTART.md) - Get started in 5 minutes
- [INSTALLATION.md](INSTALLATION.md) - Detailed setup guide
- [DEVELOPMENT.md](DEVELOPMENT.md) - Architecture and development
- [FEATURES.md](FEATURES.md) - Complete feature list
- [DESIGN_SYSTEM.md](DESIGN_SYSTEM.md) - Design specifications
- [CHANGELOG.md](CHANGELOG.md) - Version history

## 🛠️ Tech Stack

| Category | Technology |
|----------|-----------|
| Language | Swift 5.7+ |
| UI Framework | SwiftUI |
| Architecture | MVVM |
| Reactive | Combine |
| Storage | UserDefaults (demo) |
| Backend | Ready for Firebase/Custom API |

## 🎯 Roadmap

### ✅ Phase 1 - MVP (Current)
- [x] User authentication
- [x] Chat interface
- [x] Contact management
- [x] Settings and preferences
- [x] Minimalist design

### 🚧 Phase 2 - Backend
- [ ] Firebase integration
- [ ] Push notifications
- [ ] Real-time sync
- [ ] Cloud storage

### 📋 Phase 3 - Media
- [ ] Image sharing
- [ ] Video sharing
- [ ] Voice messages
- [ ] File attachments

### 🎤 Phase 4 - Calling
- [ ] Voice calls
- [ ] Video calls
- [ ] Group calls

See [FEATURES.md](FEATURES.md) for complete roadmap.

## 🤝 Contributing

Contributions are welcome! Please read [DEVELOPMENT.md](DEVELOPMENT.md) for development guidelines.

### Code Style
- Follow Swift API Design Guidelines
- Use meaningful names
- Add comments for complex logic
- Keep functions focused

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Apple's Human Interface Guidelines
- SwiftUI community
- iOS developer ecosystem

## 📬 Contact

For questions or feedback:
- Open an issue
- Submit a pull request

---

**Built with ❤️ using SwiftUI**

*SCAM - Simple. Clean. And Minimalist.*
