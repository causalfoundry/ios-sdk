// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CausalFoundry_ios_SDK",
    platforms: [.iOS(.v13)],
    
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Core",
            targets: ["CasualFoundryCore"]),
        .library(
            name: "CHWManagement",
            targets: ["CasualFoundryCHWManagement"]),
        .library(
            name: "CHWEcommerce",
            targets: ["CasualFoundryEcommerce"])
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CasualFoundryCore",
            path: "Core/Sources",
            resources: [
            .copy("Resources/usd_rates.json"),
            ]),
            .target(
                name: "CasualFoundryCHWManagement",
                dependencies:["CasualFoundryCore"], path: "CHWManagement/Sources"),
        .target(
            name: "CasualFoundryEcommerce",
            dependencies:["CasualFoundryCore"], path: "E_Commerce/Sources"
            
        ),
        
            .target(
                name: "CoreTests",
                dependencies: ["CasualFoundryCore"],
                path: "Core/Tests"),
        .testTarget(
            name: "CHWManagementTests",
            dependencies: ["CasualFoundryCHWManagement"],
            path: "CHWManagement/Tests"),
        .testTarget(
            name: "ECommerceTests",
            dependencies: ["CasualFoundryEcommerce"],
            path: "E_Commerce/Tests")
    ]
)
