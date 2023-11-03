// swift-tools-version:5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CausalFoundry_ios_SDK",
    platforms: [.iOS(.v13)],
    
    products: [
        .library(
            name: "Core",
            targets: ["CasualFoundryCore"]),
        .library(
             name: "CHWElearning",
             targets: ["CasualFoundryElearning"])
      
    ],
    targets: [
        .target(
            name: "CasualFoundryCore",
            path: "Core/Sources"
        ),
        .target(
            name: "CasualFoundryElearning",
            dependencies: ["CasualFoundryCore"],
            path: "E_Learning/Sources"
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: ["CasualFoundryCore"],
            path: "Core/Tests"
        )
    ]
)
