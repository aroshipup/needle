// swift-tools-version:5.3
import PackageDescription

let swiftSyntaxVersion: Version
let swiftSyntaxParserModule: String
#if swift(>=5.6)
swiftSyntaxVersion = "0.50600.1"
swiftSyntaxParserModule = "SwiftSyntaxParser"
#else
swiftSyntaxVersion = "0.50400.0"
swiftSyntaxParserModule = "SwiftSyntax"
#endif

let package = Package(
    name: "Needle",
    products: [
        .executable(name: "needle", targets: ["needle"]),
        .library(name: "NeedleFramework", targets: ["NeedleFramework"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-tools-support-core", .upToNextMajor(from: "0.1.5")),
        .package(url: "https://github.com/uber/swift-concurrency.git", .upToNextMajor(from: "0.6.5")),
        .package(url: "https://github.com/uber/swift-common.git", .exact("0.5.0")),
        .package(url: "https://github.com/apple/swift-syntax.git", .exact(swiftSyntaxVersion)),
    ],
    targets: [
        .target(
            name: "NeedleFramework",
            dependencies: [
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
                .product(name: "Concurrency", package: "swift-concurrency"),
                .product(name: "SourceParsingFramework", package: "swift-common"),
                .product(name: swiftSyntaxParserModule, package: "swift-syntax")
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
