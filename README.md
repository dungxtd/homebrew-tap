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

## Adding an app

1. Copy [`templates/cask.rb.tmpl`](templates/cask.rb.tmpl) to `Casks/<app>.rb` and fill the placeholders.
2. In the app repo, add the job from [`templates/dispatch-to-tap.yml.tmpl`](templates/dispatch-to-tap.yml.tmpl) to its release workflow.
3. Add the `HOMEBREW_TAP_PAT` secret to the app repo. Make sure this repo's `SOURCE_REPO_READ_PAT` can read the app repo.
4. Name release assets `<ProductName>_<label>_...`, with `<label>` one of `macos-arm64`, `macos-x64`, `windows-x64`, `windows-arm64`. `<ProductName>` must match `<app>` ignoring case.
5. Point the app's updater endpoint at `https://github.com/dungxtd/homebrew-tap/releases/download/<app>-latest/latest.json`.

## Layout

- `Casks/<app>.rb` — one cask per app.
- Releases `<app>-<version>` — versioned installers, kept as an archive.
- Release `<app>-latest` — moving pointer holding the newest installers and `latest.json` (updater manifest).
- `.github/workflows/publish-release.yml` — publishes any app's release and bumps its cask. Triggered by the app repo via `repository_dispatch`.
