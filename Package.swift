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
             targets: ["CasualFoundryElearning"]),
        .library(
            name: "CHWEPayments",
            targets: ["CasualFoundryPayments"]),
        .library(
            name: "CHWManagement",
            targets: ["CasualFoundryCHWManagement"]),
        .library(
            name: "CHWEcommerce",
            targets: ["CasualFoundryEcommerce"])
      
    ],
    targets: [
        .target(
            name: "CasualFoundryCore",
            path: "Core/Sources"
        ),
        .target(
            name: "CasualFoundryCHWManagement",
            dependencies: ["CasualFoundryCore"],
            path: "CHWManagement/Sources"
        ),
        .target(
            name: "CasualFoundryEcommerce",
            dependencies: ["CasualFoundryCore"],
            path: "E_Commerce/Sources"
        ),
        .target(
            name: "CasualFoundryPayments",
            dependencies: ["CasualFoundryCore"],
            path: "Payments/Sources"
        ),
        .target(
            name: "CasualFoundryElearning",
            dependencies: ["CasualFoundryCore"],
            path: "E_Learning/Sources"
        ),
        .target(
            name: "CoreTests",
            dependencies: ["CasualFoundryCore"],
            path: "Core/Tests"
        ),
        .testTarget(
            name: "CHWManagementTests",
            dependencies: ["CasualFoundryCHWManagement"],
            path: "CHWManagement/Tests"
        ),
        .testTarget(
            name: "ECommerceTests",
            dependencies: ["CasualFoundryEcommerce"],
            path: "E_Commerce/Tests"
        ),
        .testTarget(
            name: "PaymentsTests",
            dependencies: ["CasualFoundryPayments"],
            path: "Payments/Tests"
        )
    ]
)
