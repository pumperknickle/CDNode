// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "CDNode",
    products: [
        .library(name: "CDNode", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        // Base crypto types
        .package(url: "https://github.com/pumperknickle/CryptoStarterPack.git", from: "1.0.3"),
        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/redis.git", from: "3.4.0"),
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "CryptoStarterPack", "Redis"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

