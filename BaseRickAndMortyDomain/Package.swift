// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BaseRickAndMortyDomain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "BaseRickAndMortyDomain",
            targets: ["BaseRickAndMortyDomain"]),
    ],
    targets: [
        .target(
            name: "BaseRickAndMortyDomain"),
        .testTarget(
            name: "BaseRickAndMortyDomainTests",
            dependencies: ["BaseRickAndMortyDomain"]
        ),
    ]
)
