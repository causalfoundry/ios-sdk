// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CausalFoundry_ios_SDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CausalFoundrySDKCore",
            targets: ["CausalFoundrySDKCore"]
        ),
        .library(
            name: "CHWElearning",
            targets: ["CasualFoundryElearning"]
        ),
        .library(
            name: "CausalFoundrySDKPayments",
            targets: ["CausalFoundrySDKPayments"]
        ),
        .library(
            name: "CHWManagement",
            targets: ["CasualFoundryCHWManagement"]
        ),
        .library(
            name: "CausalFoundrySDKEcom",
            targets: ["CausalFoundrySDKEcom"]
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
            name: "CausalFoundrySDKCore",
            dependencies: ["MMKV"],
            path: "CausalFoundrySDKCore/Sources",
            exclude: [
                "CHWManagement",
                "CausalFoundrySDKEcom",
                "E_Learning",
                "Loyalty",
                "CausalFoundrySDKPayments",
            ]
        ),
        .target(
            name: "CasualFoundryCHWManagement",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CHWManagement/Sources",
            exclude: [
                "CausalFoundrySDKEcom",
                "E_Learning",
                "Loyalty",
                "CausalFoundrySDKPayments",
            ]
        ),
        .target(
            name: "CausalFoundrySDKEcom",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CausalFoundrySDKEcom/Sources",
            exclude: [
                "CHWManagement",
                "E_Learning",
                "Loyalty",
                "CausalFoundrySDKPayments",
            ]
        ),
        .target(
            name: "CausalFoundrySDKPayments",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CausalFoundrySDKPayments/Sources",
            exclude: [
                "CHWManagement",
                "CausalFoundrySDKEcom",
                "E_Learning",
                "Loyalty",
            ]
        ),
        .target(
            name: "CasualFoundryLoyalty",
            dependencies: ["CausalFoundrySDKCore"],
            path: "Loyalty/Sources",
            exclude: [
                "CHWManagement",
                "CausalFoundrySDKEcom",
                "E_Learning",
                "CausalFoundrySDKPayments",
            ]
        ),
        .target(
            name: "CasualFoundryElearning",
            dependencies: ["CausalFoundrySDKCore"],
            path: "E_Learning/Sources",
            exclude: [
                "CHWManagement",
                "CausalFoundrySDKEcom",
                "Loyalty",
                "CausalFoundrySDKPayments",
            ]
        ),
        .binaryTarget(
            name: "MMKV",
            path: "Frameworks/MMKV.xcframework"
        ),
        .testTarget(
            name: "CausalFoundrySDKCoreTests",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CausalFoundrySDKCore/Tests"
        ),
        .testTarget(
            name: "CHWManagementTests",
            dependencies: ["CasualFoundryCHWManagement"],
            path: "CHWManagement/Tests"
        ),
        .testTarget(
            name: "CausalFoundrySDKEcomTests",
            dependencies: ["CausalFoundrySDKEcom"],
            path: "CausalFoundrySDKEcom/Tests"
        ),
        .testTarget(
            name: "CausalFoundrySDKPaymentsTests",
            dependencies: ["CausalFoundrySDKPayments"],
            path: "CausalFoundrySDKPayments/Tests"
        ),
    ]
)
