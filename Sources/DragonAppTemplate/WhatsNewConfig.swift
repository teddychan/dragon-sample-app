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
            date: "2026-08-10",
            summary: L("app.whatsNew.summary"),
            sections: [
                ChangeSection(kind: .changed, entries: [
                    L("app.whatsNew.changed1"),
                ]),
            ]
        )
    }
}
