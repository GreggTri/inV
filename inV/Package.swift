
// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "MyPackage",
    dependencies: [
        .package(url: "https://github.com/mongodb/swift-bson", .upToNextMajor(from: "3.0.2"))
    ],
    targets: [
        .target(name: "inV", dependencies: ["SwiftBSON"])
    ]
)
