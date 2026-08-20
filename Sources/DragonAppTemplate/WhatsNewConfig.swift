import Foundation
import DragonKit

enum WhatsNewConfig {
    /// Release notes for the What's New pane.
    ///
    /// No `version:` argument. The heading derives from `CFBundleShortVersionString`, which is the
    /// same string the release tag is asserted against, so the pane cannot claim a release the
    /// binary isn't. This file used to pass `version: "1.4.0"` and its comment argued for it —
    /// that the notes describe one specific release and should stay pinned to it. The counter-case
    /// won: a hand-typed literal is a second source of truth that silently disagrees with the
    /// bundle the moment a release forgets to update it, and the old comment also told the reader
    /// to keep it in step with a `sample-vX.Y.Z` tag, a family the lifecycle spec has withdrawn.
    ///
    /// The obligation moves rather than disappearing: every public release updates these entries,
    /// including a maintenance-only one, and the tag gate enforces both halves — it rejects an
    /// explicit `version:` and rejects notes unchanged since the preceding public tag. This was
    /// the first violation that gate caught, on its first live run.
    ///
    /// Every entry is a localization key resolved through ``L(_:)``; the app ships its own
    /// `Localizable.strings` in seven languages, so the pane switches with the language picker.
    @MainActor
    static var content: WhatsNewContent {
        WhatsNewContent(
            date: "2026-08-20",
            summary: L("app.whatsNew.summary"),
            sections: [
                // 1.4.9 carries one user-facing change, inherited from DragonKit 4.1.1: Uninstall
                // now refuses to run when it finds more than one copy of the app on the Mac.
                // Settings, the login item and support files are keyed to the app's identity rather
                // than its location, so two copies would otherwise share all of them with no way to
                // tell whose is whose.
                ChangeSection(kind: .fixed, entries: [
                    L("app.whatsNew.fixed1"),
                ]),
                // Deliberately NOT mentioned above: DragonKit 4.1.1's other fix, a raw developer
                // error in Settings > Updates. It only ever appeared in local debug builds, so no
                // released build of Dragon Sample App could reach it — that stays out of this pane,
                // the same rule that kept it out of every other app's notes for this release.
                ChangeSection(kind: .changed, entries: [
                    L("app.whatsNew.changed1"),
                ]),
            ]
        )
    }
}
