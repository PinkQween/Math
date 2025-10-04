// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Math",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Math",
            targets: ["Math"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Math"
        ),
        .plugin(
            name: "GenerateDocumentation",
            capability: .command(
                intent: .custom(verb: "generate-documentation", description: "Build DocC documentation")
            ),
            dependencies: []
        ),
        .testTarget(
            name: "MathTests",
            dependencies: ["Math"]
        ),
    ]
)
