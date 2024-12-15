// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.
// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: shouldUseOldPlatformName() ? "SwiftXLSXForOldPlatforms" : "SwiftXLSX",
    platforms: [
        .iOS(.v10),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: shouldUseOldPlatformName() ? "SwiftXLSXForOldPlatforms" : "SwiftXLSX",
            targets: ["SwiftXLSX"]
        ),
    ],
    dependencies: [
        // 动态决定依赖版本
        .package(
            url: "https://github.com/ZipArchive/ZipArchive.git",
            shouldUseOldPlatformName() ? "2.3.0"..<"2.5.0" : .upToNextMajor(from: "2.5.0")
        )
    ],
    targets: [
        .target(
            name: "SwiftXLSX",
            dependencies: ["ZipArchive"]
        ),
        .testTarget(
            name: "SwiftXLSXTests",
            dependencies: ["SwiftXLSX"]
        ),
    ]
)

/// 判断是否应使用旧平台配置
func shouldUseOldPlatformName() -> Bool {
    #if os(iOS)
    if #available(iOS 13, *) {
        return false
    }
    #endif

    #if os(macOS)
    if #available(macOS 11, *) {
        return false
    }
    #endif

    return true
}