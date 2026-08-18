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
            date: "2026-08-18",
            summary: L("app.whatsNew.summary"),
            sections: [
                // 1.4.7 changes nothing in the app: the only commit since 1.4.6 is 1.4.6's own
                // appcast. It exists to prove the release pipeline end-to-end now that the appcast
                // and Homebrew cask land through auto-merged PRs and `main` is branch-protected in
                // all nine repos. The notes say exactly that rather than inventing a user-facing
                // change to satisfy the gate — the gate requires the notes to MOVE, not to lie.
                // Sample-app releases carrying no feature are the point of a reference host.
                ChangeSection(kind: .changed, entries: [
                    L("app.whatsNew.changed1"),
                ]),
            ]
        )
    }
}
