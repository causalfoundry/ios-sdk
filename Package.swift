// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CausalFoundry_ios_SDK",
    platforms: [.iOS(.v13)],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CausalFoundry",
            path: "Core/Sources/Core",
            publicHeadersPath: "./"
        ),
        .testTarget(
            name: "CausalFoundryTests",
            dependencies: ["CausalFoundry"]),
       
    ]
)
