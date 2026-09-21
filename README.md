# dungxtd/homebrew-tap

Homebrew tap for [@dungxtd](https://github.com/dungxtd)'s desktop apps. Hosts macOS casks, Windows installers, and auto-update manifests.

## Installation

Add the tap once:

```sh
brew tap dungxtd/tap
```

Install an app (example: nextflix):

```sh
brew install --cask dungxtd/tap/nextflix
```

## Upgrade

Apps update themselves in-app. To upgrade through Homebrew:

```sh
brew update
brew upgrade --cask <app>
```

## Uninstall

```sh
brew uninstall --cask <app>          # keep app data
brew uninstall --cask --zap <app>    # also remove app data
```

## Layout

- `Casks/<app>.rb` — one cask per app.
- Releases `<app>-<version>` — versioned installers, kept as an archive.
- Release `<app>-latest` — moving pointer holding the newest installers and `latest.json` (updater manifest).
- `.github/workflows/publish-release.yml` — publishes any app's release and bumps its cask. Triggered by the app repo via `repository_dispatch`.
