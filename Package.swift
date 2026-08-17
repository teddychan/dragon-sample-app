// swift-tools-version: 6.1
import PackageDescription

let package = Package(
    name: "DragonAppTemplate",
    defaultLocalization: "en",
    platforms: [.macOS("26")],
    dependencies: [
        // A published version pin, like every other Dragon app. This app used to live inside
        // dragon-kit and depend on it by `path: ".."`, which made it the one app exempt from
        // CONFORMANCE §R10 ("the DragonKit pin is current") — it satisfied the rule by
        // construction and so could never catch a stale kit. Now that release ownership is its
        // own repository, the exemption goes with it: this pin is checked like everyone else's.
        .package(url: "https://github.com/teddychan/dragon-kit.git", from: "4.1.0"),
    ],
    targets: [
        .executableTarget(
            name: "DragonAppTemplate",
            dependencies: [
                .product(name: "DragonKit", package: "dragon-kit"),
                .product(name: "DragonKitUpdates", package: "dragon-kit"),
            ],
            // Bundle the app's own localizations (Resources/<lang>.lproj) into
            // DragonAppTemplate_DragonAppTemplate.bundle so both run.sh and the release CI
            // ship them via the standard SwiftPM resource-bundle copy. Resolved at runtime
            // through LocalizationManager.appStringsBundle = .module (set in AppDelegate).
            resources: [.process("Resources")],
            // Embed the rpath the release CI relies on to locate the bundled
            // Sparkle.framework at Contents/Frameworks/. Without this the packaged .app only
            // carries the default @loader_path rpath, so dyld looks for Sparkle in
            // Contents/MacOS/ and the app crashes on launch (Library not loaded: Sparkle).
            linkerSettings: [
                .unsafeFlags(["-Xlinker", "-rpath", "-Xlinker", "@loader_path/../Frameworks"])
            ]
        ),
    ]
)
