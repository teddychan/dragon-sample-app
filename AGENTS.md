# AGENTS.md

Dragon Sample App is the reference macOS menu bar app (SwiftPM) that shows how a host app wires up the shared DragonKit package.

## Project rules

- Keep the bare `LanguagePicker()` call in `Sources/DragonAppTemplate/GeneralPane.swift`; don't pass DragonKit's `languages:` or `onChange:` parameters to "demonstrate" them. `languages:` means the languages the app translated itself into, and all seven of this app's `.lproj` tables carry the same keys, so a restricted list would be false and would remove working languages from installed copies. `onChange:` stays `nil` because the app uses `L(_:)` throughout and `.dragonLocalized()` switches language in place. A second "demo" picker isn't a sandbox either: it binds the shared `LocalizationManager` and changes the real app language. Both call shapes are already covered in dragon-kit by `HostWiringTests.bothLanguagePickerShapesCompileForAHost()` and `LanguagePickerOptionTests`.
