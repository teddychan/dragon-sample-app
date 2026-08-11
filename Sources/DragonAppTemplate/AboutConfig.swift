import Foundation
import DragonKit

enum AboutConfig {
    /// The single source of truth for the app version: the bundle's Info.plist, formatted by
    /// DragonKit as `v2.3.0 (23) · 2026-Jul-06 13:34:56 UTC`. Never hardcode it — bump
    /// `CFBundleShortVersionString` / `CFBundleVersion` and About, backups, and update checks
    /// all read the same value.
    static var versionString: String {
        DragonAbout.versionString()
    }

    /// Only values live here. Every row title, SF Symbol and ordering in the About pane is
    /// DragonKit's — see ``AboutContent``, which took free-form `links`/`credits` arrays until
    /// five apps used them to ship five visibly different panes.
    @MainActor
    static var content: AboutContent {
        AboutContent(
            appName: "Dragon Sample App",
            versionString: versionString,
            copyright: DragonAbout.copyright(years: "2026", holder: "Teddy Chan"),
            // Sanctioned exception to the `dragonapp.com/{app-name}-{major}` rule: the sample app
            // is the kit's reference app and has no marketing page of its own, so it points at
            // the studio hub. Every shipping app must address its own canonical page, which
            // `AboutContent.websiteMatchesSupportRepo` checks against the support row's repo —
            // and for this app that check is deliberately false, because the hub path (empty) is
            // not `dragon-sample-app`. Copying this file for a real app means replacing the hub
            // with `https://www.dragonapp.com/{repo-name}/`, matching the support row below.
            websiteURL: URL(string: "https://www.dragonapp.com")!,
            // The issues page of the repository that *owns this app*. It read
            // `teddychan/dragon-kit/issues` until 1.4.4 — left over from when the app lived
            // inside the kit — so the support row sent users to the library's tracker for a bug
            // in the app. The support row names the repo the binary is released from, always.
            supportURL: URL(string: "https://github.com/teddychan/dragon-sample-app/issues")!,
            // Required since DragonKit 4.0.0, and the fix for this app's own defect: it listed
            // `Sparkle → MIT` in Credits (below) while `licensesURL` was nil, naming a bundled
            // component whose notices were reachable nowhere. That is half of MIT compliance
            // missing — the "included in all copies" obligation is what the hosted page carries —
            // so the parameter is no longer optional and the row can no longer be omitted.
            // spectacle-2 shipped the same defect; both were found comparing all five panes.
            //
            // The trailing slash is load-bearing: it is the path GitHub Pages serves, so the row
            // resolves directly instead of through a 301.
            licensesURL: URL(string: "https://www.dragonapp.com/dragon-sample-app/licenses/")!,
            // The app's *own* licence, and the repository root carries the matching LICENSE file.
            // Distinct from `licensesURL` above, which is third-party notices; two licence-shaped
            // values that mean different things.
            license: "MIT",
            // No `originalWork:`. This app reimplements nothing, so both the `Original project`
            // link and the `Based on` credit are correctly absent — the slots collapse together.
            // 4.0.0 folded the upstream repo URL into `OriginalWork(name:author:url:)` precisely
            // so they cannot disagree: `originalProjectURL:` used to be a separate optional
            // parameter, and clipmenu-2 and ice-2 both passed the credit while omitting the URL,
            // shipping a `Based on …` row with no link to the project anywhere in the pane. An
            // app that does reimplement an upstream passes one value and gets both rows.
            attributions: [
                // The app bundles Sparkle.framework by way of DragonKitUpdates. Name → licence,
                // never a role label: this row read "Update framework → Sparkle (MIT)" while
                // clipmenu-2's read "Sparkle → MIT", which is how the canon got settled.
                Attribution(name: "Sparkle", license: "MIT"),
            ]
        )
    }
}
