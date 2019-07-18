// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "ColorSet",
    products: [
        .library(name: "ColorSet", targets: ["ColorSet"])
    ],
    targets: [
        .target(
            name: "ColorSet",
            path: "Sources",
            exclude: []
        )
    ]
)
