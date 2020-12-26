// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "URLRoute",
    products: [
        .library(name: "URLRoute", targets: ["URLRoute"]),
    ],
    targets: [
        .target(name: "URLRoute", path: "Sources"),
        .testTarget(name: "URLRouteTests", dependencies: ["URLRoute"]),
    ]
)
