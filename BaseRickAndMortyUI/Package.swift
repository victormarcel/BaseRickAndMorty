// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BaseRickAndMortyUI",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "BaseRickAndMortyUI",
            targets: ["BaseRickAndMortyUI"]),
    ],
    dependencies: [
//        .package(path: "BaseRickAndMortyDomain")
    ],
    targets: [
        .target(
            name: "BaseRickAndMortyUI"),
        .testTarget(
            name: "BaseRickAndMortyUITests",
            dependencies: ["BaseRickAndMortyUI"]
        ),
    ]
)
