// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MLBStatsProvider",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MLBStatsProvider",
            targets: ["MLBStatsProvider"]),
        .library(
            name: "MLBResponse",
            targets: ["MLBResponse"]),
    ],
    dependencies: [
        .package(url: "https://github.com/malcommac/SwiftDate", from: "7.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MLBStatsProvider",
            dependencies: [
                .product(name: "SwiftDate", package: "SwiftDate"),
                .byName(name: "MLBResponse")
            ]
        ),
        .target(
            name: "MLBResponse",
            dependencies: [
                .product(name: "SwiftDate", package: "SwiftDate"),
            ]
        )
    ]
)
