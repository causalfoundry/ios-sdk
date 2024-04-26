// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CausalFoundrySDK",
    platforms: [.iOS(.v12)],
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
            name: "CausalFoundrySDKElearn",
            targets: ["CausalFoundrySDKElearn"]
        ),
        .library(
            name: "CausalFoundrySDKPatientMgmt",
            targets: ["CausalFoundrySDKPatientMgmt"]
        ),
        .library(
            name: "CausalFoundrySDKLoyalty",
            targets: ["CausalFoundrySDKLoyalty"]
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
            name: "CausalFoundrySDKPatientMgmt",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CausalFoundrySDKPatientMgmt/Sources"
        ),
        .target(
            name: "CausalFoundrySDKLoyalty",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CausalFoundrySDKLoyalty/Sources"
        ),
        .target(
            name: "CausalFoundrySDKElearn",
            dependencies: ["CausalFoundrySDKCore"],
            path: "CausalFoundrySDKElearn/Sources"
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
            name: "CausalFoundrySDKElearnTests",
            dependencies: ["CausalFoundrySDKElearn"],
            path: "CausalFoundrySDKElearn/Tests"
        ),
        .testTarget(
            name: "CausalFoundrySDKPaymentsTests",
            dependencies: ["CausalFoundrySDKPayments"],
            path: "CausalFoundrySDKPayments/Tests"
        ),
        .testTarget(
            name: "CausalFoundrySDKLoyaltyTests",
            dependencies: ["CausalFoundrySDKLoyalty"],
            path: "CausalFoundrySDKLoyalty/Tests"
        ),
        .testTarget(
            name: "CausalFoundrySDKPatientMgmtTests",
            dependencies: ["CausalFoundrySDKPatientMgmt"],
            path: "CausalFoundrySDKPatientMgmt/Tests"
        ),
    ]
)
