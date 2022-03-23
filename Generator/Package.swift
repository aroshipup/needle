// swift-tools-version:5.6
import PackageDescription

let package = Package(
    name: "Needle",
    products: [
        .executable(name: "needle", targets: ["needle"]),
        .library(name: "NeedleFramework", targets: ["NeedleFramework"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-tools-support-core", .upToNextMajor(from: "0.1.5")),
        .package(url: "https://github.com/uber/swift-concurrency.git", .upToNextMajor(from: "0.6.5")),
        .package(url: "https://github.com/uber/swift-common.git", exact: "0.5.0"),
        .package(url: "https://github.com/apple/swift-syntax.git", exact: "0.50600.1"),
    ],
    targets: [
        .target(
            name: "NeedleFramework",
            dependencies: [
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
                .product(name: "Concurrency", package: "swift-concurrency"),
                .product(name: "SourceParsingFramework", package: "swift-common"),
                .product(name: "SwiftSyntaxParser", package: "swift-syntax"),
            ]),
        .testTarget(
            name: "NeedleFrameworkTests",
            dependencies: ["NeedleFramework"],
            exclude: [
                "Fixtures",
            ]),
        .target(
            name: "needle",
            dependencies: [
                "NeedleFramework",
                .product(name: "CommandFramework", package: "swift-common"),
            ]),
    ],
    swiftLanguageVersions: [.v5]
)
