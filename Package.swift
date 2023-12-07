// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CausalFoundry_ios_SDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "Core",
            targets: ["CasualFoundryCore"]
        ),
        .library(
            name: "CHWElearning",
            targets: ["CasualFoundryElearning"]
        ),
        .library(
            name: "CHWEPayments",
            targets: ["CasualFoundryPayments"]
        ),
        .library(
            name: "CHWManagement",
            targets: ["CasualFoundryCHWManagement"]
        ),
        .library(
            name: "CHWEcommerce",
            targets: ["CasualFoundryEcommerce"]
        ),
        .library(
            name: "CHWLoyalty",
            targets: ["CasualFoundryLoyalty"]
        ),
    ],
    /*
        dependencies: [
            .package(url: "https://github.com/Tencent/MMKV.git", exact: Version(1, 3, 2)),
        ],
        */
    targets: [
        .target(
            name: "CasualFoundryCore",
            dependencies: ["MMKV"],
            path: "Core/Sources",
            exclude: [
                "CHWManagement",
                "E_Commerce",
                "E_Learning",
                "Loyalty",
                "Payments",
            ]
        ),
        .target(
            name: "CasualFoundryCHWManagement",
            dependencies: ["CasualFoundryCore"],
            path: "CHWManagement/Sources",
            exclude: [
                "E_Commerce",
                "E_Learning",
                "Loyalty",
                "Payments",
            ]
        ),
        .target(
            name: "CasualFoundryEcommerce",
            dependencies: ["CasualFoundryCore"],
            path: "E_Commerce/Sources",
            exclude: [
                "CHWManagement",
                "E_Learning",
                "Loyalty",
                "Payments",
            ]
        ),
        .target(
            name: "CasualFoundryPayments",
            dependencies: ["CasualFoundryCore"],
            path: "Payments/Sources",
            exclude: [
                "CHWManagement",
                "E_Commerce",
                "E_Learning",
                "Loyalty",
            ]
        ),
        .target(
            name: "CasualFoundryLoyalty",
            dependencies: ["CasualFoundryCore"],
            path: "Loyalty/Sources",
            exclude: [
                "CHWManagement",
                "E_Commerce",
                "E_Learning",
                "Payments",
            ]
        ),
        .target(
            name: "CasualFoundryElearning",
            dependencies: ["CasualFoundryCore"],
            path: "E_Learning/Sources",
            exclude: [
                "CHWManagement",
                "E_Commerce",
                "Loyalty",
                "Payments",
            ]
        ),
        .binaryTarget(
            name: "MMKV",
            path: "Frameworks/MMKV.xcframework"
        ),
        .testTarget(
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
        ),
    ]
)
