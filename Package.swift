// swift-tools-version: 5.4
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "KenkaiSDK",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "KenkaiSDKCore",
            targets: ["KenkaiSDKCore"]
        ),
        .library(
            name: "KenkaiSDKEcom",
            targets: ["KenkaiSDKEcom"]
        ),
        .library(
            name: "KenkaiSDKPayments",
            targets: ["KenkaiSDKPayments"]
        ),
        .library(
            name: "KenkaiSDKElearn",
            targets: ["KenkaiSDKElearn"]
        ),
        .library(
            name: "KenkaiSDKPatientMgmt",
            targets: ["KenkaiSDKPatientMgmt"]
        ),
        .library(
            name: "KenkaiSDKLoyalty",
            targets: ["KenkaiSDKLoyalty"]
        ),
    ],
    /*
        dependencies: [
            .package(url: "https://github.com/Tencent/MMKV.git", exact: Version(1, 3, 2)),
        ],
        */
    targets: [
        .target(
            name: "KenkaiSDKCore",
            dependencies: ["MMKV"],
            path: "KenkaiSDKCore/Sources"
        ),
        .target(
            name: "KenkaiSDKEcom",
            dependencies: ["KenkaiSDKCore"],
            path: "KenkaiSDKEcom/Sources"
        ),
        .target(
            name: "KenkaiSDKPayments",
            dependencies: ["KenkaiSDKCore"],
            path: "KenkaiSDKPayments/Sources"
        ),
        .target(
            name: "KenkaiSDKPatientMgmt",
            dependencies: ["KenkaiSDKCore"],
            path: "KenkaiSDKPatientMgmt/Sources"
        ),
        .target(
            name: "KenkaiSDKLoyalty",
            dependencies: ["KenkaiSDKCore"],
            path: "KenkaiSDKLoyalty/Sources"
        ),
        .target(
            name: "KenkaiSDKElearn",
            dependencies: ["KenkaiSDKCore"],
            path: "KenkaiSDKElearn/Sources"
        ),
        .binaryTarget(
            name: "MMKV",
            path: "Frameworks/MMKV.xcframework"
        ),
        .testTarget(
            name: "KenkaiSDKCoreTests",
            dependencies: ["KenkaiSDKCore"],
            path: "KenkaiSDKCore/Tests"
        ),
        .testTarget(
            name: "KenkaiSDKEcomTests",
            dependencies: ["KenkaiSDKEcom"],
            path: "KenkaiSDKEcom/Tests"
        ),
        .testTarget(
            name: "KenkaiSDKElearnTests",
            dependencies: ["KenkaiSDKElearn"],
            path: "KenkaiSDKElearn/Tests"
        ),
        .testTarget(
            name: "KenkaiSDKPaymentsTests",
            dependencies: ["KenkaiSDKPayments"],
            path: "KenkaiSDKPayments/Tests"
        ),
        .testTarget(
            name: "KenkaiSDKLoyaltyTests",
            dependencies: ["KenkaiSDKLoyalty"],
            path: "KenkaiSDKLoyalty/Tests"
        ),
        .testTarget(
            name: "KenkaiSDKPatientMgmtTests",
            dependencies: ["KenkaiSDKPatientMgmt"],
            path: "KenkaiSDKPatientMgmt/Tests"
        ),
    ]
)
