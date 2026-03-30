// swift-tools-version: 6.1
// This is a Skip (https://skip.dev) package.
import PackageDescription

let package = Package(
    name: "thuisarts-skip",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "ThuisartsSkip", type: .dynamic, targets: ["ThuisartsSkip"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "1.7.4"),
        .package(url: "https://source.skip.tools/skip-fuse-ui.git", from: "1.0.0")
    ],
    targets: [
        .target(name: "ThuisartsSkip", dependencies: [
            .product(name: "SkipFuseUI", package: "skip-fuse-ui")
        ], resources: [.process("Resources")], plugins: [.plugin(name: "skipstone", package: "skip")]),
    ]
)
