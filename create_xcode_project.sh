#!/bin/bash

echo "Creating proper Xcode project structure..."

# Create project structure
mkdir -p SCAM/SCAM
mkdir -p SCAM/SCAM/Resources

# Move all Swift files to SCAM/SCAM/
find . -maxdepth 1 -name "*.swift" -exec mv {} SCAM/SCAM/ \;
mv Models SCAM/SCAM/ 2>/dev/null || true
mv Views SCAM/SCAM/ 2>/dev/null || true
mv ViewModels SCAM/SCAM/ 2>/dev/null || true
mv Services SCAM/SCAM/ 2>/dev/null || true
mv Utilities SCAM/SCAM/ 2>/dev/null || true

# Move resources
mv Assets.xcassets SCAM/SCAM/Resources/ 2>/dev/null || true
mv Info.plist SCAM/SCAM/ 2>/dev/null || true

echo "✅ Project structure created!"
echo "Now creating Xcode project file..."
