// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BaseRickAndMortyService",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "BaseRickAndMortyService",
            targets: ["BaseRickAndMortyService"]),
    ],
    dependencies: [
        .package(path: "BaseRickAndMortyDomain")
    ],
    targets: [
        .target(
            name: "BaseRickAndMortyService"),
        .testTarget(
            name: "BaseRickAndMortyServiceTests",
            dependencies: ["BaseRickAndMortyService"]
        ),
    ]
)
