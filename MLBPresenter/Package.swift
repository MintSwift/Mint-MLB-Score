// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MLBPresenter",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MLBPresenter",
            targets: ["MLBPresenter"]),
    ],
    dependencies: [
        .package(path: "../MLBDomain/MLBDomain"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MLBPresenter",
            dependencies: [
                .byName(name: "MLBDomain")
            ]
        ),
        .testTarget(
            name: "MLBPresenterTests",
            dependencies: ["MLBPresenter"]),
    ]
)
