# Installation Guide

## Prerequisites

- **macOS**: 13.0 or later
- **Xcode**: 14.0 or later
- **iOS**: 16.0 or later (for deployment)

## Setup Steps

### 1. Clone or Download Project
Place all project files in a folder named `SCAM`

### 2. Open in Xcode
```bash
cd SCAM
open SCAM.xcodeproj
```

### 3. Configure Bundle Identifier
1. Select the project in navigator
2. Go to "Signing & Capabilities"
3. Change bundle identifier to your own (e.g., `com.yourname.scam`)
4. Select your development team

### 4. Build and Run
- Select target device/simulator
- Press `Cmd + R` or click the Play button

## Troubleshooting

### "Could not find module"
- Clean build folder: `Cmd + Shift + K`
- Rebuild: `Cmd + B`

### Signing Issues
- Ensure you have a valid Apple Developer account
- Select "Automatically manage signing"

### Simulator Issues
- Reset simulator: Device → Erase All Content and Settings
- Restart Xcode

## Next Steps

1. Run the app
2. Create an account with any username
3. Explore the features
4. Check DEVELOPMENT.md for architecture details
