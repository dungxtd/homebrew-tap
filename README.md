# dungxtd/homebrew-tap

Homebrew tap hosting macOS + Windows builds and updater manifests for [@dungxtd](https://github.com/dungxtd) apps.

## Install

```sh
brew tap dungxtd/tap
brew install --cask <app>
```

## Upgrade

Apps self-update via in-app updater. Force via Homebrew:

```sh
brew upgrade --cask <app>
```

## Casks

| Cask | Description | Install |
| --- | --- | --- |
| [nextflix](Casks/nextflix.rb) | Torrent-streaming video player | `brew install --cask dungxtd/tap/nextflix` |
