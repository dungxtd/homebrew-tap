cask "nextflix" do
  version "1.1.0"

  on_arm do
    sha256 "2ed1cf30cd70ef46bbe1b0db56abda4cf65b57155878f582a2ed34d52932e423"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-universal_Nextflix_#{version}_universal.dmg"
  end

  on_intel do
    sha256 "2ed1cf30cd70ef46bbe1b0db56abda4cf65b57155878f582a2ed34d52932e423"
    url "https://github.com/dungxtd/homebrew-tap/releases/download/nextflix-v#{version}/Nextflix_macos-universal_Nextflix_#{version}_universal.dmg"
  end

  name "Nextflix"
  desc "Next version of flix"
  homepage "https://github.com/dungxtd/homebrew-tap"

  depends_on macos: :big_sur

  app "Nextflix.app"

  # The DMG is ad-hoc signed (no Apple Developer ID + notarization yet), so
  # Gatekeeper attaches com.apple.quarantine and refuses to launch the app
  # with "damaged/cannot verify" on first open. Strip the attribute on install.
  # Remove this block once we move to Developer ID + notarytool.
  postflight_steps do
    run "/usr/bin/xattr",
        args: ["-dr", "com.apple.quarantine", "{{appdir}}/Nextflix.app"]
  end

  zap trash: [
    "~/Library/Application Support/nextflix",
    "~/Library/Logs/Nextflix",
    "~/Library/Caches/nextflix",
    "~/Library/Preferences/nextflix.plist",
  ]
end
