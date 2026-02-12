// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "SCAM",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SCAM",
            targets: ["SCAM"]
        )
    ],
    targets: [
        .target(
            name: "SCAM",
            dependencies: [],
            path: "Sources",
            resources: [
                .process("Resources")
            ]
        )
    ]
)
