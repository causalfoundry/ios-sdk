// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CausalFoundrySDK",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "CausalFoundrySDKCore",
            targets: ["CausalFoundrySDKCore"]
        ),
        .library(
            name: "CausalFoundrySDKEcom",
            targets: ["CausalFoundrySDKEcom"]
        ),
        .library(
            name: "CausalFoundrySDKPayments",
            targets: ["CausalFoundrySDKPayments"]
        ),
        .library(
            name: "CHWElearning",
            targets: ["CasualFoundryElearning"]
        ),
        .library(
            name: "CHWManagement",
            targets: ["CasualFoundryCHWManagement"]
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
            path: "CausalFoundrySDKCore/Sources"
        ),
        .target(
            name: "CausalFoundrySDKEcom",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CausalFoundrySDKEcom/Sources"
        ),
        .target(
            name: "CausalFoundrySDKPayments",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CausalFoundrySDKPayments/Sources"
        ),
        .target(
            name: "CasualFoundryCHWManagement",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CHWManagement/Sources"
        ),
        .target(
            name: "CasualFoundryLoyalty",
            dependencies: ["CausalFoundrySDKCore"],
            path: "Loyalty/Sources"
        ),
        .target(
            name: "CasualFoundryElearning",
            dependencies: ["CausalFoundrySDKCore"],
            path: "E_Learning/Sources"
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
            name: "CausalFoundrySDKEcomTests",
            dependencies: ["CausalFoundrySDKEcom"],
            path: "CausalFoundrySDKEcom/Tests"
        ),
        .testTarget(
            name: "CausalFoundrySDKPaymentsTests",
            dependencies: ["CausalFoundrySDKPayments"],
            path: "CausalFoundrySDKPayments/Tests"
        ),
        .testTarget(
            name: "CHWManagementTests",
            dependencies: ["CasualFoundryCHWManagement"],
            path: "CHWManagement/Tests"
        ),
    ]
)
