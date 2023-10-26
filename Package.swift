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
            name: "CHW_Management",
            targets: ["CasualFoundry_CHW_Management"])
       
    ],
   targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CasualFoundryCore",
            path: "Core/Sources",
            exclude: ["SampleApp"]
        ),
        .target(
            name: "CasualFoundry_CHW_Management",
            dependencies:["CasualFoundryCore"], path: "CHW_Management/Sources",
            exclude: ["SampleApp"]
           
        ),
        
        .testTarget(
        name: "CoreTests",
        dependencies: ["CasualFoundryCore"],
        path: "Core/Tests"
        
    )]
)
